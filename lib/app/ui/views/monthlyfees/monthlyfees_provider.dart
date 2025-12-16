import 'dart:convert';
import 'dart:io';
import 'package:cip_payment_web/app/providers/infodevice_provider.dart';
import 'package:cip_payment_web/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_web/app/ui/views/views.dart';
import 'package:cip_payment_web/domain/entities/deviceinfo.dart';
import 'package:cip_payment_web/domain/entities/enums.dart';
import 'package:cip_payment_web/domain/entities/payment.dart';
import 'package:cip_payment_web/domain/entities/quota.dart';
import 'package:cip_payment_web/domain/entities/token.dart';
import 'package:cip_payment_web/infrastructure/datasources/logdb_datasource.dart';
import 'package:cip_payment_web/infrastructure/datasources/paymentdb_datasource.dart';
import 'package:cip_payment_web/infrastructure/datasources/quotadb_datasource.dart';
import 'package:cip_payment_web/app/ui/components/toast/toast.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/widgets/automatic_pay.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/widgets/link_pay.dart';
import 'package:cip_payment_web/core/config/environment.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/helpers/custom_snackbar.dart';
import 'package:cip_payment_web/core/helpers/generate_receipt.dart';
import 'package:cip_payment_web/core/helpers/helpers.dart';
import 'package:cip_payment_web/core/preferences/shared_preferences.dart';
import 'package:cip_payment_web/infrastructure/models/logtime_model.dart';
import 'package:cip_payment_web/infrastructure/models/quota_model.dart';
import 'package:cip_payment_web/infrastructure/models/response/payment_model.dart';
import 'package:cip_payment_web/infrastructure/repositories/log_repository_impl.dart';
import 'package:cip_payment_web/infrastructure/repositories/payment_repository_impl.dart';
import 'package:cip_payment_web/infrastructure/repositories/quota_repository_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyfeesProvider with ChangeNotifier {
  final QuotaRepositoryImpl quotaRepositoryImpl = QuotaRepositoryImpl(
    QuotadbDatasource(),
  );
  final PaymentRepositoryImpl paymentRepositoryImpl = PaymentRepositoryImpl(
    PaymentdbDatasource(),
  );

  final LogRepositoryImpl logRepositoryImpl = LogRepositoryImpl(
    LogdbDatasource(),
  );

  Timestamp dtOnEntry = Timestamp.fromDate(DateTime.now());

  Future<void> onInit(BuildContext context) async {
    selectTab(0);
    await getDataPerson(context);
    // response = await http.get(Uri.parse('https://ifconfig.me/all.json'));
    getInfoDevice(context);
    fetchPendingPay(context);
    await getHistoryPayment(context);
    dtOnEntry = Timestamp.fromDate(DateTime.now());
  }

  Future<void> getDataPerson(BuildContext context) async {
    personId = PreferencesUser.personId;
    mainEmail = PreferencesUser.mainEmail;
    // print(personId);
    // print(mainEmail);
  }

  String rucId = '';
  int receiptType = 0; //0 boleta, 1: facura

  String mainEmail = '';
  String personId = '';
  String variablePrueba = 'hola id';
  int _selectedIndex = 0;
  final PageController pageController = PageController();
  int get selectedIndex => _selectedIndex;
  double amoutToPay = 0;

  TextEditingController ctrlCardNumber = TextEditingController(
    text: '4111111111111111',
  );
  TextEditingController ctrlCvv = TextEditingController(text: '123');
  TextEditingController ctrlExpirationMonth = TextEditingController(text: '12');
  TextEditingController ctrlExpirationYear = TextEditingController(
    text: '2030',
  );
  TextEditingController ctrlEmail = TextEditingController(
    text: 'review@culqi.com',
  );
  List<Payment> paymentHistoryQuotas = [];
  bool isGettinHistory = false;
  double amount = 1000.0;
  Token tokenCreate = Token();

  //Crea el token y envia solicitud de pago createToken
  Future<void> payMonthlyFees() async {
    final response = await paymentRepositoryImpl.createTokenCulqi(
      cardNumber: ctrlCardNumber.text,
      cvv: ctrlCvv.text,
      expirationMonth: ctrlExpirationMonth.text,
      expirationYear: ctrlExpirationYear.text,
      email: ctrlEmail.text,
    );

    if (response != null) {
      debugPrint(response.toString());
      tokenCreate = response;
      paymentRepositoryImpl.payCulqi(
        tokenCreate.id!,
        Helpers.toCents(amount),
        ctrlEmail.text,
      ); // Enviar este token a tu backend para crear el cargo
    } else {
      // Mostrar error al usuario
    }
  }

  Future<String?> crearTokenCulqi() async {
    final uri = Uri.parse("https://api.culqi.com/v2/tokens");
    final client = HttpClient();

    final req = await client.postUrl(uri);
    req.headers.set('Content-Type', 'application/json');
    req.headers.set('Authorization', 'Bearer pk_test_sKWDD6bVub17VOqt');

    req.add(
      utf8.encode(
        json.encode({
          "card_number": ctrlCardNumber.text,
          "cvv": ctrlCvv.text,
          "expiration_month": ctrlExpirationMonth.text,
          "expiration_year": ctrlExpirationYear.text,
          "email": ctrlEmail.text,
        }),
      ),
    );

    final res = await req.close();
    final body = await res.transform(utf8.decoder).join();
    client.close();

    if (res.statusCode == 201) {
      final data = json.decode(body);
      print(data['id']);
      return data['id'];
    } else {
      print("Error creando token (HttpClient): $body");
      return null;
    }
  }

  void selectTab(int index) {
    _selectedIndex = index;
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  void onPageChanged(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void goToAutomaticPay(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AutomaticPay()),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  List<Quota> listQuotas = [];
  bool isGettingPendingPay = true;

  Future<void> fetchPendingPay(BuildContext context) async {
    debugPrint('get cuotas pendientes');
    isGettingPendingPay = true;
    listQuotas.clear();
    try {
      final response = await quotaRepositoryImpl.fetchQuotasByPerson(personId);
      listQuotas.addAll(response);
      listQuotas.sort((a, b) => (a.feeMonth ?? 0).compareTo(b.feeMonth ?? 0));
      toggleSelectAll();
    } catch (e) {
      showToastGlobal(
        context,
        1,
        "error",
        "Ocurrio un error al tratar de optener sus cuotas pendientes. Detalles: $e",
      );
    } finally {
      isGettingPendingPay = false;
      notifyListeners();
    }
  }

  void togglePaid(int index, bool value) {
    if (value) {
      // ✅ Si quiere marcar, primero aseguramos que todas las anteriores estén marcadas
      for (int i = 0; i <= index; i++) {
        listQuotas[i].isSelected = true;
      }
    } else {
      // ❌ Si quiere desmarcar, también desmarcamos todas las posteriores
      for (int i = index; i < listQuotas.length; i++) {
        listQuotas[i].isSelected = false;
      }
    }
    notifyListeners();
  }

  //   double get totalSelected {
  //   return listQuotas
  //       .where((q) => q.isSelected)
  //       .fold(0.0, (sum, q) => sum + q.amount );
  // }
  double get totalSelected {
    return listQuotas
        .where((q) => q.isSelected)
        .fold(0.0, (totalsum, q) => totalsum + (q.amount ?? 0));
  }

  bool get allSelected =>
      listQuotas.isNotEmpty && listQuotas.every((q) => q.isSelected);

  void toggleSelectAll() {
    final allSelected = listQuotas.every((q) => q.isSelected);
    for (var quota in listQuotas) {
      quota.isSelected = !allSelected;
    }
    notifyListeners();
  }

  Future<void> getHistoryPayment(BuildContext context) async {
    paymentHistoryQuotas.clear();
    isGettinHistory = true;
    try {
      final response = await paymentRepositoryImpl.historyPaymentQuotas(
        personId,
        PaymentType.monthlyFees.code,
      );
      if (response == null) {
        return;
      }
      paymentHistoryQuotas.addAll(response);
      paymentHistoryQuotas.sort(
        (a, b) => (b.feeMonth ?? 0).compareTo(a.feeMonth ?? 0),
      );
    } catch (e) {
      showToastGlobal(context, 1, "error", kmessageErrorGeneral);
      debugPrint(e.toString());
    } finally {
      isGettinHistory = false;
      notifyListeners();
    }
  }

  Future<void> openCheckout(BuildContext context, person) async {
    try {
      debugPrint(totalSelected.toString());
      final int amountRound = Helpers.toCents(totalSelected);

      final token = await CulqiWeb.openCheckout(
        publicKey: Environment.publicKeyCulqi,
        amount: amountRound, // en céntimos: 60000 = S/600.00
        currency: "PEN",
        email: 'review@culqi.com',
      );

      if (token != null) {
        showDialog(
          context: context,
          barrierDismissible: false, // no permite cerrar tocando afuera
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
              context: context,
              builder: (BuildContext context) {
                return PopupGeneral(
                  title: '',
                  onTapButton: () {},
                  scrollable: false,
                  content: PaymentGood(
                    payCompleted.creationDate ?? 0,
                    totalSelected,
                    textMonthlyfees,
                    PaymentType.monthlyFees.code,
                  ),
                );
              },
            );
            final payment = PaymentModel(
              creationDatePay: Timestamp.fromDate(DateTime.now()),
              deviceInfoPay: deviceInfo?.nameDevice ?? '',
              ipAddressPay: deviceInfo?.ip ?? '',
              locationCityPay: deviceInfo?.nameCity ?? '',
              locationCountryPay: deviceInfo?.nameCountry ?? '',
              locationPay: GeoPoint(
                deviceInfo?.latitude ?? 0.0,
                deviceInfo?.longitude ?? 0,
              ),
              paymentState: true,
              paymentValue: totalSelected,
              personId: personId,
              platformPayment: PlatformPayment.app.name,
              quantityPayment: 1,
              receiptType: receiptType, //ReceiptType.bill.code,
              typePay: PaymentType.monthlyFees.code,
              paymentChannel: PaymentChannel.online.code,
              rucId: rucId,
              feeMonth: 0, //ya no aplica porque se sabra de la tabla intermedia
              feeYear: 0, //ya no aplica porque se sabra de la tabla intermedia
              specialtyId: '',
            );

            List<QuotaModel> quotaModel = listQuotas
                .where((q) => q.isSelected) // 1. Solo las cuotas seleccionadas
                .map(
                  (q) => QuotaModel(
                    id: q.id ?? '',
                    personId: q.personId ?? '',
                    isSelected: q.isSelected,
                  ),
                )
                .toList();

            final paymentMade = await paymentRepositoryImpl.payment(payment);
            await paymentRepositoryImpl.paymentDetail(
              quotaModel,
              paymentMade?.id ?? '',
              PaymentType.monthlyFees.code,
            );
            await quotaRepositoryImpl.updateQuotas(quotaModel);
            fetchPendingPay(context);
            getHistoryPayment(context);

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
              paymentId: paymentMade?.id,
              typePay: PaymentType.monthlyFees.code,
              typePayName: PaymentType.monthlyFees.name,
            );
            createLog(logTime);
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return PopupGeneral(
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
      debugPrint('Error in payment process: $e');
    } finally {
      cleanVariables();
    }
  }

  void prueba() {
    for (var quota in listQuotas) {
      print(quota.id);
    }
  }

  List<Quota> listQuotasPayment = [];
  Future<void> getPaymentFeesByPayment(String paymentId) async {
    // print('getPaymentFeesByPayment');
    // paymentId = 'QzbIRNyfLXWWfs6p2YB2';
    listQuotasPayment.clear();
    try {
      final response = await paymentRepositoryImpl.getPaymentFeesByPaymentId(
        paymentId,
      );
      print(response.length);
      listQuotasPayment.addAll(response);
      listQuotasPayment.sort(
        (a, b) => (a.feeMonth ?? 0).compareTo(b.feeMonth ?? 0),
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  void cleanVariables() {
    rucId = '';
    receiptType = 0;
  }

  Future<void> createLog(LogtimeModel logTime) async {
    try {
      logRepositoryImpl.createLog(logTime);
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

    Future<void> getReceipt(
    String receiptNumber,
    String date,
    String name,
    String dni,
    double subtotal,
  ) async {
    print(listQuotasPayment.length);
    final igv = subtotal * 0.18;
    await generateReceipt(
      receiptNumber: receiptNumber,
      date: date,
      name: name,
      dni: dni,
      subtotal: subtotal - igv,
      igv: igv,
      total: subtotal,
      typePay: textMonthlyfees,
      storepay: listQuotasPayment,
    );
  }

  DeviceInfo? deviceInfo;
  void getInfoDevice(context) async {
    deviceInfo = await Provider.of<InfodeviceProvider>(
      context,
      listen: false,
    ).deviceInfo();
  }
}
