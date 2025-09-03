import 'package:flutter/widgets.dart';

class AdvancepaymentProvider with ChangeNotifier{

  TextEditingController ctrlLastPay = TextEditingController(text:'Agosto de 2024');
  TextEditingController ctrlQuantityCuotas = TextEditingController(text:'12');
  TextEditingController ctrlEnabledUntil = TextEditingController(text:'Noviembre del 2024');
  TextEditingController ctrlSubTotal = TextEditingController(text:'S/. 270');
  TextEditingController ctrlDiscount = TextEditingController(text:'S/. 30');
  TextEditingController ctrlTotal = TextEditingController(text:'S/. 240');
}