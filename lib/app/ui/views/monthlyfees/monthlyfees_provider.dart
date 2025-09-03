import 'dart:convert';
import 'dart:io';
import 'package:cip_payment_web/app/models/quota_model.dart';
import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/app/ui/components/toast/toast.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/widgets/automatic_pay.dart';
import 'package:cip_payment_web/core/helpers/custom_snackbar.dart';
import 'package:cip_payment_web/preferences/shared_preferences.dart';
import 'package:cip_payment_web/services/culqi_service.dart';
import 'package:cip_payment_web/services/firebase/monthlyfees_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MonthlyfeesProvider with ChangeNotifier {
  final monthlyfeesService = MonthlyfeesService();

  String variablePrueba = 'hola id';
  int _selectedIndex = 0;
  final PageController pageController = PageController();
  int get selectedIndex => _selectedIndex;

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
  bool isGettingPendingPay = false;

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
      notifyListeners();
    }
  }

  double amoutToPay = 0;
  void togglePaid(int index, bool value) {
    listQuotas[index].isSelected = value;

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

  bool get allSelected => listQuotas.isNotEmpty && listQuotas.every((q) => q.isSelected);

  void toggleSelectAll() {
    final allSelected = listQuotas.every((q) => q.isSelected);
    for (var quota in listQuotas) {
      quota.isSelected = !allSelected;
    }
    notifyListeners();
  }
}
