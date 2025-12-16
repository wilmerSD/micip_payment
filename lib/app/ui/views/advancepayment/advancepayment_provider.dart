import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/app/providers/infodevice_provider.dart';
import 'package:cip_payment_web/app/ui/components/alert/popup_checkout.dart';
import 'package:cip_payment_web/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_web/app/ui/components/payment/payment_bad.dart';
import 'package:cip_payment_web/app/ui/components/payment/payment_good.dart';
import 'package:cip_payment_web/app/ui/components/payment/warning_pay.dart';
import 'package:cip_payment_web/app/ui/components/toast/toast.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/widgets/link_pay.dart';
import 'package:cip_payment_web/core/config/environment.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/helpers/custom_snackbar.dart';
import 'package:cip_payment_web/core/helpers/helpers.dart';
import 'package:cip_payment_web/core/preferences/shared_preferences.dart';
import 'package:cip_payment_web/domain/entities/deviceinfo.dart';
import 'package:cip_payment_web/domain/entities/enums.dart';
import 'package:cip_payment_web/domain/entities/payment.dart';
import 'package:cip_payment_web/domain/entities/person.dart';
import 'package:cip_payment_web/domain/entities/quota.dart';
import 'package:cip_payment_web/infrastructure/datasources/logdb_datasource.dart';
import 'package:cip_payment_web/infrastructure/datasources/paymentdb_datasource.dart';
import 'package:cip_payment_web/infrastructure/datasources/quotadb_datasource.dart';
import 'package:cip_payment_web/infrastructure/models/logtime_model.dart';
import 'package:cip_payment_web/infrastructure/models/quota_model.dart';
import 'package:cip_payment_web/infrastructure/models/response/payment_model.dart';
import 'package:cip_payment_web/infrastructure/repositories/log_repository_impl.dart';
import 'package:cip_payment_web/infrastructure/repositories/payment_repository_impl.dart';
import 'package:cip_payment_web/infrastructure/repositories/quota_repository_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AdvancepaymentProvider with ChangeNotifier {
  final QuotaRepositoryImpl quotaRepositoryImpl =
      QuotaRepositoryImpl(QuotadbDatasource());
  final PaymentRepositoryImpl paymentRepositoryImpl = PaymentRepositoryImpl(
    PaymentdbDatasource(),
  );
  final LogRepositoryImpl logRepositoryImpl =
      LogRepositoryImpl(LogdbDatasource());

  bool isGetQuotasPending = false;
  bool haveQuotasPending = true;
  final String symbolMoney = 'S/. ';

  String ctrlValueOfQuota = 'S/. 20.0';
  String ctrlPercentDiscount = '5%';
  String ctrlSubTotal = 'S/. 270';
  String ctrlDiscount = 'S/. 30';

  TextEditingController ctrlQuantityCuotas = TextEditingController(text: '12');
  final PageController pageController = PageController();

  double totalToPay = 0;
  double valueOfQuota = 20.0;
  Timestamp dtOnEntry = Timestamp.fromDate(DateTime.now());

  Future<void> onInit(BuildContext context) async {
    selectTab(0);
    getInfoDevice(context);
    await getDataPerson();
    hasQuotasPending(context);
    fetchLastQuotaByPerson();
    getHistoryPayment(context);
    calculateToPay();
    dtOnEntry = Timestamp.fromDate(DateTime.now());
  }

  String personId = '';
  String mainEmail = '';
  Future<void> getDataPerson() async {
    personId = PreferencesUser.personId;
    mainEmail = PreferencesUser.mainEmail;
  }

  Future<void> openCheckout(BuildContext context, Person? person) async {
    try {
      final int amountRound = Helpers.toCents(totalToPay);
      final token = await CulqiWeb.openCheckout(
        publicKey: Environment.publicKeyCulqi,
        amount: amountRound, // en céntimos: 60000 = S/600.00
        currency: "PEN",
        email: 'review@culqi.com',
      );
      
      if (token != null) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(child: CircularProgressIndicator());
          },
        );

        debugPrint(token);
        final payCompleted = await paymentRepositoryImpl.payCulqi(
          token,
          amountRound,
          mainEmail,
        );
        Navigator.of(context).pop(); // cierra el loader
        if (payCompleted != null) {
          if (payCompleted.succces) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return PopupCheckout(
                  title: '',
                  onTapButton: () {},
                  scrollable: false,
                  content: PaymentGood(
                    payCompleted.creationDate ?? 0,
                    totalToPay,
                    textCertificateskill,
                    PaymentType.advancepay.code,
                  ),
                );
              },
            );

            final cuantityQuotas = int.parse(ctrlQuantityCuotas.text);
            //TODO: GUARDAR EN LA TABLA DE PAYMENT EL PAGO REALIZADO
            PaymentModel paymentQuota = PaymentModel(
              creationDatePay: Timestamp.fromDate(DateTime.now()),
              deviceInfoPay: deviceInfo?.nameDevice ?? '',
              ipAddressPay: deviceInfo?.ip ?? '',
              locationCityPay: deviceInfo?.nameCity ?? '',
              locationCountryPay: deviceInfo?.nameCountry ?? '',
              locationPay: GeoPoint(
                  deviceInfo?.latitude ?? 0.0, deviceInfo?.longitude ?? 0.0),
              paymentState: true,
              paymentValue: totalToPay, // el monto del certificado
              personId: personId,
              platformPayment: PlatformPayment.app.name,
              quantityPayment: 1, // cada uno representa un certificado
              receiptType: receiptType, //ReceiptType.bill.code,
              typePay: PaymentType.advancepay.code,
              paymentChannel: PaymentChannel.online.code,
              rucId: rucId,
              feeMonth: 0,
              feeYear: 0,
              specialtyId: '',
            );
            final paymentMade = await paymentRepositoryImpl
                .payment(paymentQuota); //Tabla de pago
            generateAdvancedQuotas(context, cuantityQuotas,
                paymentMade); //Genera las cuotas adelantadas
            fetchLastQuotaByPerson();

            final name = person?.namePerson ?? '';
            final maternalSurname = person?.motherSurname ?? '';
            final paternalSurname = person?.paternalSurname ?? '';

            LogtimeModel logTime = LogtimeModel(
              personId: personId,
              cip: person?.numberCip ?? '',
              dni: person?.dni ?? '',
              fullNames: '$name $maternalSurname $paternalSurname',
              paymentDateEnd: Timestamp.fromDate(DateTime.now()),
              paymentDateStart: dtOnEntry,
              paymentId: paymentMade?.id ?? '',
              typePay: PaymentType.advancepay.code,
              typePayName: PaymentType.advancepay.name,
            );
            createLog(logTime);
            getHistoryPayment(context);
          } else {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return PopupCheckout(
                  title: '',
                  onTapButton: () {},
                  scrollable: false,
                  content: PaymentBad(
                    Helpers.generateRandomOperationNumber(),
                    Helpers.formatCustomDate(payCompleted.creationDate),
                    payCompleted.userMessage ?? '',
                  ),
                );
              },
            );
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      cleanVariables();
    }
  }

  bool stateCollegiate = false;
  Future<void> hasQuotasPending(BuildContext context) async {
    stateCollegiate = true;
    try {
      final response = await quotaRepositoryImpl.hasPendingQuotas(personId);
      haveQuotasPending = response;
      if (haveQuotasPending) {
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return PopupGeneral(
              title: '',
              onTapButton: () {},
              scrollable: true,
              content: WarningPay(
                  'Para poder generar tu certificado de habilidad debe pagar su deuda pendiente.'),
            );
          },
        );
        stateCollegiate = false; // Deshabilitado
      }
      //TODO: si es false entonces hacer la petición hasta cuando esta habilitado
    } catch (e) {
      CustomSnackbar.showSnackBarCustom(
        context,
        title: 'Error',
        message: kmessageErrorGeneral,
        type: 2,
        time: 2,
      );
    } finally {
      notifyListeners();
      // haveQuotasPending = false;
    }
  }

  bool isGettinHistory = false;
  List<Payment> paymentHistory = [];

  Future<void> getHistoryPayment(BuildContext context) async {
    paymentHistory.clear();
    isGettinHistory = true;

    try {
      final response = await paymentRepositoryImpl.historyPaymentQuotas(
          personId, PaymentType.advancepay.code);
      if (response == null) {
        return;
      }
      paymentHistory.addAll(response);
      paymentHistory.sort((a, b) => (b.feeMonth ?? 0)
          .compareTo(a.feeMonth ?? 0)); //Ordena de mayor a menor
      // print('id de historial'+ paymentHistory[0].id!); 
    } catch (e) {
      CustomSnackbar.showSnackBarCustom(
        context,
        title: 'Error',
        message: kmessageErrorGeneral,
        type: 2,
        time: 2,
      );
      debugPrint(e.toString());
    } finally {
      isGettinHistory = false;
      notifyListeners();
    }
  }

  String enabledUntil = '-';
  Quota lastQuotaMade = Quota(isSelected: false);
  Future<void> fetchLastQuotaByPerson() async {
    enabledUntil = '-';
    try {
      final response =
          await quotaRepositoryImpl.fetchLastQuotaByPerson(personId);
      if (response == null) {
        return;
      }
      lastQuotaMade = response;
      enabledUntil =
          '${Helpers.getNameMonth(response.feeMonth ?? 0)} del ${response.feeYear}';
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> generateAdvancedQuotas(
      BuildContext context, int cuantityQuotas, Payment? paymentMade
      // Person person,
      ) async {
    try {
      final person =
          Provider.of<AuthProvider>(context, listen: false).currentPerson;
      // 1️⃣ Obtener la última cuota pagada
      final lastQuota =
          await quotaRepositoryImpl.fetchLastQuotaByPerson(personId);
      final now = DateTime.now();
      int currentMonth = lastQuota?.feeMonth ?? now.month;
      int currentYear = lastQuota?.feeYear ?? now.year;

      // 2️⃣ Generar nuevas cuotas
      List<QuotaModel> paymentQuotaModels =
          List.generate(cuantityQuotas, (index) {
        // Avanzar al siguiente mes
        currentMonth++;
        if (currentMonth > 12) {
          currentMonth = 1;
          currentYear++;
        }

        return QuotaModel(
          id: '', // Firestore lo genera
          personId: personId,
          namePerson: person?.namePerson,
          motherSurname: person?.motherSurname,
          paternalSurname: person?.paternalSurname,
          dni: person?.dni,
          fullNamePerson:
              '${person?.namePerson} ${person?.paternalSurname} ${person?.motherSurname}',
          amount: 19, //valor de la cuota descontando por adelanto 5%
          feeMonth: currentMonth,
          feeYear: currentYear,
          status: 'completed', // Porque estás pagando por adelantado
          createdAt: Timestamp.fromDate(DateTime.now()),
          updatedAt: Timestamp.fromDate(DateTime.now()),
          dueDate: Timestamp.fromDate(
              DateTime(currentYear, currentMonth, 10)), // Por ejemplo, día 10
          isSelected: false,
        );
      });

      // 3️⃣ Guardar las cuotas en la base de datos
      final quotasCreated =
          await quotaRepositoryImpl.createQuotasByPerson(paymentQuotaModels);

      final quotasToCreate = List.generate(quotasCreated?.length ?? 0, (index) {
        return QuotaModel(
          id: quotasCreated?[index].id ?? '', // Firestore lo genera
          amount: 20, //valor de la cuota
          isSelected: false,
        );
      });

      if (quotasCreated != null) {
        await paymentRepositoryImpl.paymentDetail(
            quotasToCreate,
            paymentMade?.id ?? '',
            PaymentType.advancepay.code); //Tabla de pagoDetalle
      }

      debugPrint(
          '✅ ${paymentQuotaModels.length} cuotas adelantadas creadas correctamente');
    } catch (e) {
       CustomSnackbar.showSnackBarCustom(
        context,
        title: 'Error',
        message: '❌ Error al generar cuotas adelantadas: $e',
        type: 2,
        time: 2,
      );
      // debugPrint('❌ Error al generar cuotas adelantadas: $e');
    }
  }

  List<Quota> listQuotasPayment = [];
  Future<List<Quota>?> getPaymentFeesByPayment(String paymentId) async {
    listQuotasPayment.clear();
    try {
      final response =
          await paymentRepositoryImpl.getPaymentFeesByPaymentId(paymentId);
      listQuotasPayment.addAll(response);
      listQuotasPayment
          .sort((a, b) => (a.feeMonth ?? 0).compareTo(b.feeMonth ?? 0));
      print(listQuotasPayment[0].feeMonth);
      return listQuotasPayment;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    } finally {}
  }

  int quantityCuotas = 0;
  double discount = 0.0;
  double subTotal = 0.0;

  DeviceInfo? deviceInfo;
  void getInfoDevice(context) async {
    deviceInfo = await Provider.of<InfodeviceProvider>(context, listen: false)
        .deviceInfo();
  }

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  void onPageChanged(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void selectTab(int index) {
    _selectedIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  String wouldEnableUntil = '';
  int currentMonth = DateTime.now().month;
  void calculateToPay() {
    quantityCuotas = int.tryParse(ctrlQuantityCuotas.text) ?? 0;
    subTotal = (valueOfQuota * quantityCuotas);
    discount = subTotal * 0.05;
    totalToPay = subTotal - discount;

    ctrlDiscount = symbolMoney + discount.toString();
    ctrlSubTotal = symbolMoney + subTotal.toString();
    calculateEnabledUntil();
    notifyListeners();
  }

  void calculateEnabledUntil({int? month, int? year}) {
    int currentMonth = lastQuotaMade.feeMonth ?? DateTime.now().month;
    int currentYear = lastQuotaMade.feeYear ?? DateTime.now().year;

    int totalMonths = currentMonth + quantityCuotas;

    // Calculamos el nuevo mes y año
    int newYear = currentYear + ((totalMonths - 1) ~/ 12);
    int newMonth = ((totalMonths - 1) % 12) + 1;

    String mesNombre = Helpers.getNameMonth(newMonth);

    wouldEnableUntil = '$mesNombre del $newYear';
  }

  String rucId = '';
  int receiptType = 0; //0 boleta, 1: facura
  void cleanVariables() {
    rucId = '';
    receiptType = 0;
  }

  Future<void> createLog(LogtimeModel logTime) async {
    try {
      await logRepositoryImpl.createLog(logTime);
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }
}
