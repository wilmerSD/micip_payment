import 'dart:convert';
import 'dart:io';
import 'package:cip_payment_web/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_web/app/ui/views/views.dart';
import 'package:cip_payment_web/domain/entities/quota.dart';
import 'package:cip_payment_web/domain/entities/token.dart';
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
import 'package:cip_payment_web/infrastructure/models/quota_model.dart';
import 'package:cip_payment_web/infrastructure/models/response/payment_quota_model.dart';
import 'package:cip_payment_web/infrastructure/repositories/payment_repository_impl.dart';
import 'package:cip_payment_web/infrastructure/repositories/quota_repository_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MonthlyfeesProvider with ChangeNotifier {
  final QuotaRepositoryImpl quotaRepositoryImpl = QuotaRepositoryImpl(
    QuotadbDatasource(),
  );
  final PaymentRepositoryImpl paymentRepositoryImpl = PaymentRepositoryImpl(
    PaymentdbDatasource(),
  );

  Future<void> onInit(BuildContext context) async {
    selectTab(0);
    await getDataPerson(context);
    fetchPendingPay(context);
    // response = await http.get(Uri.parse('https://ifconfig.me/all.json'));
  }

  Future<void> getDataPerson(BuildContext context) async {
    personId = PreferencesUser.personId;
    mainEmail = PreferencesUser.mainEmail;
    print(personId);
    print(mainEmail);
  }

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
  List<Quota> paymentHistoryQuotas = [];
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

  //Pagar v1 pagar
  Future<void> payMonthlyFeesv1(BuildContext context) async {
    await generateReceipt(
      receiptNumber: 'prueba',
      date: '07/09/25',
      name: 'JOSE WILMER SANCHEZ DIAZ',
      dni: '70833688',
      subtotal: 25,
      igv: 12,
      total: 280,
    );
    debugPrint('tratando de generar recibo');
    final token = await paymentRepositoryImpl.createTokenCulqi(
      cardNumber: ctrlCardNumber.text,
      cvv: ctrlCvv.text,
      expirationMonth: ctrlExpirationMonth.text,
      expirationYear: ctrlExpirationYear.text,
      email: ctrlEmail.text,
    );
    if (token != null) {
      final response = await paymentRepositoryImpl.payCulqi(
        token.id!,
        Helpers.toCents(amount),
        ctrlEmail.text,
      ); // Enviar este token a tu backend para crear el cargo
      if (response != null) {
        //TODO verificar si el pago fue exitoso o no
        Navigator.pop(context);
        CustomSnackbar.showSnackBarCustom(
          context,
          title: 'Éxito',
          message: 'El pago se realizo correctamente',
          type: 3,
          time: 2,
        );
      } else {
        CustomSnackbar.showSnackBarCustom(
          context,
          title: 'Validar',
          message: 'Ups...Ocurrio un error, intente nuevamente',
          type: 2,
          time: 2,
        );
      }
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
      final response = await quotaRepositoryImpl.historyPaymentQuotas(personId);
      paymentHistoryQuotas.addAll(response);
    } catch (e) {
      showToastGlobal(context, 1, "error", kmessageErrorGeneral);
      debugPrint(e.toString());
    } finally {
      isGettinHistory = false;
      notifyListeners();
    }
  }

  Future<void> openCheckout(BuildContext context) async {
    debugPrint(totalSelected.toString());
    final int amountRound = Helpers.toCents(totalSelected);
    final token = await CulqiWeb.openCheckout(
      publicKey: Environment.publicKeyCulqi,
      amount: amountRound, // en céntimos: 60000 = S/600.00
      currency: "PEN",
      email: '',
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
                  Helpers.formatCustomDate(payCompleted.creationDate),
                  payCompleted.amount!.toDouble(),
                  textMonthlyfees,
                ),
              );
            },
          );
          List<PaymentQuotaModel> paymentQuotaModels = listQuotas
              .where((q) => q.isSelected) // 1. Solo las cuotas seleccionadas
              .map(
                (q) => PaymentQuotaModel(
                  creationDatePay: Timestamp.fromDate(DateTime.now()),
                  deviceInfoPay: '',
                  ipAddressPay: '',
                  locationCityPay: '',
                  locationCountryPay: '',
                  locationPay: LocationPay(latitude: 0, longitude: 0),
                  paymentDate: Timestamp.fromDate(DateTime.now()),
                  paymentState: true,
                  paymentValue: q.amount,
                  personId: personId,
                  platformPayment: '',
                  quantityPayment: 0,
                  receiptFormatPay: 0,
                  receiptTypePay: 0,
                ),
              )
              .toList();
          await paymentRepositoryImpl.payQuotas(paymentQuotaModels);

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
          
          await quotaRepositoryImpl.updateQuotas(quotaModel);
          fetchPendingPay(context);
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
  }
  void prueba(){
    for ( var quota in listQuotas){
      print(quota.id); 
    }
  }
}
