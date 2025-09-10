import 'dart:convert';
import 'dart:io';
import 'package:cip_payment_web/app/models/paymentgenerated_model.dart';
import 'package:cip_payment_web/app/models/quota_model.dart';
import 'package:cip_payment_web/app/ui/components/toast/toast.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/widgets/automatic_pay.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/helpers/custom_snackbar.dart';
import 'package:cip_payment_web/core/helpers/generate_receipt.dart';
import 'package:cip_payment_web/preferences/shared_preferences.dart';
import 'package:cip_payment_web/services/culqi_service.dart';
import 'package:cip_payment_web/services/firebase/quotas_service.dart';
import 'package:flutter/material.dart';

class MonthlyfeesProvider with ChangeNotifier {
  final monthlyfeesService = QuotasService();

  String variablePrueba = 'hola id';
  int _selectedIndex = 0;
  final PageController pageController = PageController();
  int get selectedIndex => _selectedIndex;
  double amoutToPay = 0;
  CulqiService culquiServise = CulqiService();

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
  double amount = 1000.0;

  Future<void> createToken() async {
    String? token = await culquiServise.crearTokenCulqi(
      cardNumber: ctrlCardNumber.text,
      cvv: ctrlCvv.text,
      expirationMonth: ctrlExpirationMonth.text,
      expirationYear: ctrlExpirationYear.text,
      email: ctrlEmail.text,
    );
    print(token);
    if (token != null) {
      culquiServise.payCulqui(
        token,
        amount,
        ctrlEmail.text,
      ); // Enviar este token a tu backend para crear el cargo
    } else {
      // Mostrar error al usuario
    }
  }

  Future<void> pagar(BuildContext context) async {
    print('asdasdasdasdasd');
    await generateReceipt(
      receiptNumber: 'prueba',
      date: '07/09/25',
      name: 'JOSE WILMER SANCHEZ DIAZ',
      dni: '70833688',
      subtotal: 25,
      igv: 12,
      total: 280,
    );
    print('tratando de generar recibo');
    // return;
    final token = await crearTokenCulqi();
    final response = await culquiServise.payCulqui(
      token ?? '',
      amount,
      ctrlEmail.text,
    ); // Enviar este token a tu backend para crear el cargo

    if (response) {
      Navigator.pop(context);
      CustomSnackbar.showSnackBarCustom(
        context,
        title: 'Éxito',
        message: 'El pago se realizo correctamente',
        type: 3,
        time: 2,
      );
      return;
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

  List<QuotaModel> listQuotas = [];
  bool isGettingPendingPay = true;

  Future<void> fetchPendingPay(BuildContext context) async {
    isGettingPendingPay = true;
    listQuotas.clear();
    final id = PreferencesUser.personId;
    try {
      final response = await monthlyfeesService.fetchAllQuotas(id);
      listQuotas = response;

      listQuotas.sort((a, b) => (a.feeMonth ?? 0).compareTo(b.feeMonth ?? 0));
    } catch (e) {
      showToastGlobal(
        context,
        1,
        "error",
        "Ocurrio un error al tratar de optener sus cuotas pendientes. Detalles: $e",
      );
    } finally {
      
      isGettingPendingPay = false;
      print(isGettingPendingPay);
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

  List<PaymentgeneratedModel> paymentHistoryQuotas = [];
  bool isGettinHistory = false;

  Future<void> getHistoryPayment(BuildContext context) async {
    paymentHistoryQuotas.clear();
    isGettinHistory = true;
    final personId = PreferencesUser.personId;
    try {
      final response = await monthlyfeesService.historyPaymentQuotas(personId);
      paymentHistoryQuotas.addAll(response);
    } catch (e) {
      showToastGlobal(context, 1, "error", kmessageErrorGeneral);
      debugPrint(e.toString());
    } finally {
      isGettinHistory = false;
      notifyListeners();
    }
  }
}
