import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/app/ui/components/payment_tile.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/widgets/nohistory_view.dart';
import 'package:cip_payment_web/app/ui/views/proofnodebt/proofnodebt_provider.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProofnodebtHistory extends StatelessWidget {
  const ProofnodebtHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final proofnodebtProvider = Provider.of<ProofnodebtProvider>(context);
    final auth = context.read<AuthProvider>().currentPerson;
    final name = auth?.namePerson ?? '';
    final maternalSurname = auth?.motherSurname ?? '';
    final paternalSurname = auth?.paternalSurname ?? '';
    final dni = auth?.dni ?? '';
    final fullName = "$name $paternalSurname $maternalSurname";
    return proofnodebtProvider.paymentHistory.isEmpty
        ? const NohistoryView()
        : ListView(
          children: [
            SingleChildScrollView(
                child: Wrap(
                    spacing: 30.0,
                    runSpacing: 10.0,
                    children: List.generate(
                        proofnodebtProvider.paymentHistory.length, (index) {
                      final payment = proofnodebtProvider.paymentHistory[index];
                      final paymentDate = payment.creationDatePay;
                      final amount = payment.paymentValue?.toDouble() ?? 0.0;
                      final paymentDateStr = Helpers.timestampToString(paymentDate);
                      
                      return PaymentTile(
                        paymentDateStr,
                        Helpers.typePay(payment.receiptType), () {}, '$amount',
                        'Pagado el $paymentDateStr', true, 
                        receiptNumber: paymentDate?.seconds.toString() ?? '',
                        date: Helpers.formatDateFromTimestamp(paymentDate),
                        name: fullName,
                        dni: dni,
                        subtotal: amount,
                        typePay: textProofnodebt,
                        enabledUntil: proofnodebtProvider.enabledUntil,
                        speciality: proofnodebtProvider.specialityToPdf,
                      );
                    }))),
          ],
        );
  }
}
