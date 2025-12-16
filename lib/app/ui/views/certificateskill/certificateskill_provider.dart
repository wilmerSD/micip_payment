import 'package:cip_payment_web/app/providers/infodevice_provider.dart';
import 'package:cip_payment_web/app/ui/components/alert/popup_checkout.dart';
import 'package:cip_payment_web/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_web/app/ui/components/payment/payment_bad.dart';
import 'package:cip_payment_web/app/ui/components/payment/payment_good.dart';
import 'package:cip_payment_web/app/ui/components/toast/toast.dart';
import 'package:cip_payment_web/app/ui/components/payment/warning_pay.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/widgets/link_pay.dart';
import 'package:cip_payment_web/core/config/environment.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/helpers/custom_snackbar.dart';
import 'package:cip_payment_web/core/helpers/generate_receipt.dart';
import 'package:cip_payment_web/core/helpers/helpers.dart';
import 'package:cip_payment_web/core/preferences/shared_preferences.dart';
import 'package:cip_payment_web/domain/entities/deviceinfo.dart';
import 'package:cip_payment_web/domain/entities/enums.dart';
import 'package:cip_payment_web/domain/entities/payment.dart';
import 'package:cip_payment_web/domain/entities/person.dart';
import 'package:cip_payment_web/domain/entities/speciality.dart';
import 'package:cip_payment_web/infrastructure/datasources/logdb_datasource.dart';
import 'package:cip_payment_web/infrastructure/datasources/paymentdb_datasource.dart';
import 'package:cip_payment_web/infrastructure/datasources/quotadb_datasource.dart';
import 'package:cip_payment_web/infrastructure/datasources/specialitydb_datasource.dart';
import 'package:cip_payment_web/infrastructure/models/logtime_model.dart';
import 'package:cip_payment_web/infrastructure/models/response/payment_model.dart';
import 'package:cip_payment_web/infrastructure/models/select_model.dart';
import 'package:cip_payment_web/infrastructure/repositories/log_repository_impl.dart';
import 'package:cip_payment_web/infrastructure/repositories/payment_repository_impl.dart';
import 'package:cip_payment_web/infrastructure/repositories/quota_repository_impl.dart';
import 'package:cip_payment_web/infrastructure/repositories/speciality_repository_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CertificateSkillProvider with ChangeNotifier {
  final PaymentRepositoryImpl paymentRepositoryImpl = PaymentRepositoryImpl(
    PaymentdbDatasource(),
  );
  final SpecialityRepositoryImpl specialityRepositoryImpl =
      SpecialityRepositoryImpl(SpecialitydbDatasource());
  final LogRepositoryImpl logRepositoryImpl =
      LogRepositoryImpl(LogdbDatasource());

  double valueCertificate = 15;
  String rucId = '';
  bool stateCollegiate = false;
  TextEditingController quantityCertificate = TextEditingController(text: '1');
  final PageController pageController = PageController();

  bool haveQuotasPending = true;
  final QuotaRepositoryImpl quotaRepositoryImpl =
      QuotaRepositoryImpl(QuotadbDatasource());
  double amountToPay = 15.0;
  String mainEmail = '';
  String personId = '';

  int receiptType = 0; //0 boleta, 1: facura
  Timestamp dtOnEntry = Timestamp.fromDate(DateTime.now());

  Future<void> onInit(BuildContext context) async {
    selectTab(0);
    getInfoDevice(context);
    await getDataPerson();
    getSpecilaities(personId);
    hasQuotasPending(context);
    fetchLastQuotaByPerson();
    getHistoryPayment(context);
    dtOnEntry = Timestamp.fromDate(DateTime.now());
  }
  Future<void> getDataPerson() async {
    personId = PreferencesUser.personId;
    mainEmail = PreferencesUser.mainEmail;
  }

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
        message: 'Ocurrio un error tratando de obtener si tiene cuotas pendientes $e',
        type: 2,
        time: 2,
      );
    } finally {
  
    }
  }

  Future<void> openCheckout(BuildContext context, Person? person) async {
    try {
      final int amountRound = Helpers.toCents(amountToPay);
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
                    amountToPay,
                    textCertificateskill,
                    PaymentType.certificateskill.code,
                  ),
                );
              },
            );

            final cuantityCert = int.parse(quantityCertificate.text);
            List<PaymentModel> paymentQuotaModels =
                List.generate(cuantityCert, (index) {
              return PaymentModel(
                creationDatePay: Timestamp.fromDate(DateTime.now()),
                deviceInfoPay: deviceInfo?.nameDevice ?? '',
                ipAddressPay: deviceInfo?.ip ?? '',
                locationCityPay: deviceInfo?.nameCity ?? '',
                locationCountryPay: deviceInfo?.nameCountry ?? '',
                locationPay: GeoPoint(
                    deviceInfo?.latitude ?? 0.0, deviceInfo?.longitude ?? 0.0),
                paymentState: true,
                paymentValue: valueCertificate, // el monto del certificado
                personId: personId,
                platformPayment: PlatformPayment.app.name,
                quantityPayment: 1, // cada uno representa un certificado
                receiptType: receiptType, //ReceiptType.bill.code,
                typePay: PaymentType.certificateskill.code,
                paymentChannel: PaymentChannel.online.code,
                rucId: rucId,
                feeMonth: 0,
                feeYear: 0,
                specialtyId: currectSpecialty.id,
              );
            });
            /* PaymentModel paymentModel = PaymentModel(
              creationDatePay: Timestamp.fromDate(DateTime.now()),
              deviceInfoPay: deviceInfo?.nameDevice ?? '',
              ipAddressPay: deviceInfo?.ip ?? '',
              locationCityPay: deviceInfo?.nameCity ?? '',
              locationCountryPay: deviceInfo?.nameCountry ?? '',
              locationPay: GeoPoint(
                  deviceInfo?.latitude ?? 0.0, deviceInfo?.longitude ?? 0.0),
              paymentState: true,
              paymentValue: valueCertificate * cuantityCert, // el monto del certificado
              personId: personId,
              platformPayment: PlatformPayment.app.name,
              quantityPayment: 1, // cada uno representa un certificado
              receiptType: receiptType, //ReceiptType.bill.code,
              typePay: PaymentType.certificateskill.code,
              paymentChannel: PaymentChannel.online.code,
              rucId: rucId,
              feeMonth: 0,
              feeYear: 0,
              specialtyId: currectSpecialty.id,
            ); */

            /* List<QuotaModel> paymentDetail =
                List.generate(cuantityCert, (index) {
              return QuotaModel(
                id: currectSpecialty.id,
                personId: personId,
                amount: valueCertificate.toInt(),
                isSelected: false,
              );
            }); */

            final quotas = await paymentRepositoryImpl.payQuotas(paymentQuotaModels);
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
              paymentId: quotas?[0].id,
              typePay: PaymentType.certificateskill.code,
              typePayName: PaymentType.certificateskill.name,
            );
            createLog(logTime);
            getHistoryPayment(context);
           /*  final paymentMade = await paymentRepositoryImpl
                .payment(paymentModel); //Guardo en la tabla payment
            await paymentRepositoryImpl.paymentDetail(paymentDetail,
                paymentMade?.id ?? '', PaymentType.certificateskill.code); */
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
    } finally {
      cleanVariables();
    }
  }

  bool isGettinHistory = false;
  List<Payment> paymentHistory = [];

  Future<void> getHistoryPayment(BuildContext context) async {
    paymentHistory.clear();
    isGettinHistory = true;
    print(personId);
    try {
      final response = await paymentRepositoryImpl.historyPaymentQuotas(
          personId, PaymentType.certificateskill.code);
      if (response == null) {
        return;
      }
      paymentHistory.addAll(response);
      paymentHistory.sort((a, b) => (b.feeMonth ?? 0)
          .compareTo(a.feeMonth ?? 0)); //Ordena de mayor a menor
          // print(paymentHistory[1].id);
    } catch (e) {
      CustomSnackbar.showSnackBarCustom(
        context,
        title: 'Error',
        message: 'Ocurrio un error tratando de obtener el historial de pagos $e',
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
  Future<void> fetchLastQuotaByPerson() async {
    try {
      final response =
          await quotaRepositoryImpl.fetchLastQuotaByPerson(personId);
      if (response == null) {
        return;
      }
      print(response.id);
      enabledUntil =
          '${Helpers.getNameMonth(response.feeMonth ?? 0)} del ${response.feeYear}';
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }

  List<Speciality> listSpecialities = [];
  SelectModel currectSpecialty = SelectModel(id: '0', value: 'Seleccionar');

  Future<void> getSpecilaities(String personId) async {
    listSpecialities.clear();
    final response = await specialityRepositoryImpl.getSpecialties(personId);
    listSpecialities.addAll(response);
    if (response.isNotEmpty && currectSpecialty.id == '0') {
      final first = listSpecialities.first;
      currectSpecialty = SelectModel(
        id: first.id ?? '',
        value: first.nameSpeciality ?? '',
      );
    }
    notifyListeners();
  }

  // Speciality specialityToCertificate = Speciality();
  Speciality getSpecialityToCertificate(String specialityId) {
  if (listSpecialities.isEmpty) {
    return Speciality();
    // throw Exception('La lista de especialidades está vacía');
  }

  return listSpecialities.firstWhere(
    (item) => item.id == specialityId,
    orElse: () => listSpecialities[0], // si no lo encuentra, devuelve el primero
  );
}

  Future<void> getReceipt(
    String receiptNumber,
    String date,
    String name,
    String dni,
    double subtotal,
  ) async {
    final igv = subtotal * 0.18;
    await generateReceipt(
      receiptNumber: receiptNumber,
      date: date,
      name: name,
      dni: dni,
      subtotal: subtotal - igv,
      igv: igv,
      total: subtotal,
      typePay: textCertificateskill,
    );
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

  DeviceInfo? deviceInfo;
  void getInfoDevice(context) async {
    deviceInfo = await Provider.of<InfodeviceProvider>(context, listen: false)
        .deviceInfo();
  }

  void updateAmount() {
    amountToPay = 0;
    if (quantityCertificate.text.isNotEmpty) {
      final quantityCert = int.parse(quantityCertificate.text);
      amountToPay = valueCertificate * quantityCert;
    }
    notifyListeners();
  }

  void prueba() {
    final prueba = currectSpecialty.id;
    print(prueba);
  }

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
