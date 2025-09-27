import 'package:cip_payment_web/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_web/app/ui/components/payment/warning_pay.dart';
import 'package:cip_payment_web/app/ui/components/toast/toast.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/preferences/shared_preferences.dart';
import 'package:cip_payment_web/infrastructure/datasources/quotadb_datasource.dart';
import 'package:cip_payment_web/infrastructure/repositories/quota_repository_impl.dart';
import 'package:flutter/material.dart';

class ProofnodebtProvider with ChangeNotifier {
  final QuotaRepositoryImpl quotaRepositoryImpl = QuotaRepositoryImpl(QuotadbDatasource());
  bool isGetQuotasPending = false;
  bool haveQuotasPending = true;

  Future<void> onInit(BuildContext context) async {
    await getPendingQuotas(context);
  }

  Future<void> getPendingQuotas(BuildContext context) async {
    final personId = PreferencesUser.personId;
    try {
      final response = await quotaRepositoryImpl.hasPendingQuotas(personId);
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
