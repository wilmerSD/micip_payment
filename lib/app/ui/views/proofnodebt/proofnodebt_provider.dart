import 'package:cip_payment_web/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_web/app/ui/components/payment/warning_pay.dart';
import 'package:cip_payment_web/app/ui/components/toast/toast.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/preferences/shared_preferences.dart';
import 'package:cip_payment_web/services/firebase/quotas_service.dart';
import 'package:flutter/material.dart';

class ProofnodebtProvider with ChangeNotifier {
  final QuotasService quotasService = QuotasService();
  bool isGetQuotasPending = false;
  bool haveQuotasPending = true;

  Future<void> onInit(BuildContext context) async {
    await getPendingQuotas(context);
  }

  Future<void> getPendingQuotas(BuildContext context) async {
    final personId = PreferencesUser.personId;
    try {
      final response = await quotasService.quotasPendint(personId);
      haveQuotasPending = response;
      if (haveQuotasPending) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return PopupGeneral(
              title: '',
              onTapButton: () {},
              scrollable: true,
              content: WarningPay(
                'Para poder generar su constancia de no adeudo debe pagar su deuda pendiente.',
              ),
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
}
