import 'package:cip_payment_web/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_web/app/ui/components/payment/warning_pay.dart';
import 'package:cip_payment_web/app/ui/components/toast/toast.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/preferences/shared_preferences.dart';
import 'package:cip_payment_web/services/firebase/quotas_service.dart';

import 'package:flutter/material.dart';


class AdvancepaymentProvider with ChangeNotifier{
  
  final QuotasService quotasService = QuotasService();
  bool isGetQuotasPending = false;
  bool haveQuotasPending = true;
  final String symbolMoney = 'S/. ';

  TextEditingController ctrlValueOfQuota = TextEditingController(text:'S/. 30.0');
  TextEditingController ctrlPercentDiscount = TextEditingController(text:'5%');

  TextEditingController ctrlLastPay = TextEditingController(text:'Agosto de 2024');
  TextEditingController ctrlQuantityCuotas = TextEditingController(text:'12');
  TextEditingController ctrlEnabledUntil = TextEditingController(text:'Noviembre del 2024');
  TextEditingController ctrlSubTotal = TextEditingController(text:'S/. 270');
  TextEditingController ctrlDiscount = TextEditingController(text:'S/. 30');
  TextEditingController ctrlTotal = TextEditingController(text:'S/. 240');
  

  double totalToPay = 0;
  double valueOfQuota = 30.0;

  Future<void> onInit(BuildContext context) async {
    final personId = PreferencesUser.personId;
    try {
      final response = await quotasService.quotasPendint(personId);
      haveQuotasPending = response;
      print(haveQuotasPending);
      if (haveQuotasPending) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return PopupGeneral(
              title: '',
              onTapButton: () {},
              scrollable: true,
              content: WarningPay('Para poder adelantar cuotas debe pagar su deuda pendiente.'),
            );
          },
        );
       
      }
    } catch (e) {
      showToastGlobal(context, 2, "info", kmessageErrorGeneral);
    } finally {
      // haveQuotasPending = false;
    }
  }
  int quantityCuotas = 0;
  double discount = 0.0;
  double subTotal = 0.0;
  void calculateToPay(){
    
    quantityCuotas = int.tryParse(ctrlQuantityCuotas.text) ?? 0;
    subTotal = (valueOfQuota * quantityCuotas);
    discount = subTotal * 0.05;
    totalToPay = subTotal - discount;

    ctrlDiscount.text = symbolMoney+discount.toString();
    ctrlSubTotal.text = symbolMoney+subTotal.toString();
    notifyListeners();
    }
}