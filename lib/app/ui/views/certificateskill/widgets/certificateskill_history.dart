import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/app/ui/components/payment_tile.dart';
import 'package:cip_payment_web/app/ui/views/certificateskill/certificateskill_provider.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/widgets/nohistory_view.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CertificateskillHistory extends StatelessWidget {
  const CertificateskillHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final certificateSkillProvider =
        Provider.of<CertificateSkillProvider>(context);
    final auth = context.read<AuthProvider>().currentPerson;
    final name = auth?.namePerson ?? '';
    final maternalSurname = auth?.motherSurname ?? '';
    final paternalSurname = auth?.paternalSurname ?? '';
    final dni = auth?.dni ?? '';
    final fullName = "$name $paternalSurname $maternalSurname";
    return certificateSkillProvider.paymentHistory.isEmpty
        ? const NohistoryView()
        : SingleChildScrollView(
            child: Wrap(
                spacing: 30.0,
                runSpacing: 10.0,
                children: List.generate(
                    certificateSkillProvider.paymentHistory.length, (index) {
                  final payment =
                      certificateSkillProvider.paymentHistory[index];
                  final paymentDate = payment.creationDatePay;
                  final amount = payment.paymentValue?.toDouble() ?? 0.0;
                  final paymentDateStr = Helpers.timestampToString(paymentDate);
                  final speciality = certificateSkillProvider
                      .getSpecialityToCertificate(payment.specialtyId ?? '');
                  return PaymentTile(
                      paymentDateStr, Helpers.typePay(payment.receiptType), () {
                    // certificateSkillProvider.getReceipt(
                    //   paymentDate?.seconds.toString() ?? '',
                    //   paymentDateStr,
                    //   fullName,
                    //   dni,
                    //   amount,
                    // );
                  }, '$amount', 'Pagado el $paymentDateStr',
                   true,
                      receiptNumber: paymentDate?.seconds.toString() ?? '',
                      date: paymentDateStr,
                      name: fullName,
                      dni: dni,
                      subtotal: amount,
                      typePay: textCertificateskill,
                      /* speciality: speciality */);
                }
                ))
            // PaymentTile(
            //     '',
            //     'text',
            //     (){},
            //     "textSecond",
            //     "textThird",
            //     true
            // ),

            );
  }
}
