import 'package:cip_payment_web/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_web/app/ui/components/toast/toast.dart';
import 'package:cip_payment_web/app/ui/components/payment/warning_pay.dart';
import 'package:cip_payment_web/core/preferences/shared_preferences.dart';
import 'package:cip_payment_web/infrastructure/datasources/quotadb_datasource.dart';
import 'package:cip_payment_web/infrastructure/repositories/quota_repository_impl.dart';
import 'package:flutter/material.dart';

class CertificateSkillProvider with ChangeNotifier {
  final QuotaRepositoryImpl quotaRepositoryImpl = QuotaRepositoryImpl(QuotadbDatasource());

  TextEditingController ctrlNumberCip = TextEditingController(
    text: '972 243 232',
  );
  TextEditingController ctrlColegiado = TextEditingController(
    text: 'José Guevara Martinez',
  );
  TextEditingController ctrlState = TextEditingController(text: 'Activo');
  TextEditingController ctrlEnabledUntil = TextEditingController(
    text: '31 de Agosto del 2025',
  );
  TextEditingController ctrlNumberCertf = TextEditingController(text: '01');
  TextEditingController ctrlSpecialty = TextEditingController(
    text: 'Ing. De Sistemas e informática',
  );

  bool isGetQuotasPending = false;
  bool haveQuotasPending = true;
  Future<void> onInit(BuildContext context) async {
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
              content: WarningPay('Para poder generar tu certificado de habilidad debe pagar su deuda pendiente.'),
            );
          },
        );
       
      }
    } catch (e) {
      showToastGlobal(context, 2, "info", "Ingresar contraseña.");
    } finally {
      notifyListeners();
      // haveQuotasPending = false;
    }
  }
}
