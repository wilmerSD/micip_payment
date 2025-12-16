import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/app/ui/components/payment_tile.dart';
import 'package:cip_payment_web/app/ui/views/advancepayment/advancepayment_provider.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/widgets/nohistory_view.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/helpers/generate_receipt.dart';
import 'package:cip_payment_web/core/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdvancepaymentHistory extends StatelessWidget {
  const AdvancepaymentHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final advancepaymentHistory = Provider.of<AdvancepaymentProvider>(context);
    final auth = context.read<AuthProvider>().currentPerson;
    final name = auth?.namePerson ?? '';
    final maternalSurname = auth?.motherSurname ?? '';
    final paternalSurname = auth?.paternalSurname ?? '';
    final dni = auth?.dni ?? '';
    final fullName = "$name $paternalSurname $maternalSurname";
    return advancepaymentHistory.paymentHistory.isEmpty
        ? const NohistoryView()
        : SingleChildScrollView(
            child: Wrap(
                spacing: 30.0,
                runSpacing: 10.0,
                children: List.generate(
                    advancepaymentHistory.paymentHistory.length, (index) {
                  final payment = advancepaymentHistory.paymentHistory[index];
                  final paymentDate = payment.creationDatePay;
                  final amount = payment.paymentValue?.toDouble() ?? 0.0;
                  final paymentDateStr = Helpers.timestampToString(paymentDate);
                  final igv = amount * 0.18;
                  return PaymentTile(
                    paymentDateStr,
                    Helpers.typePay(payment.receiptType),
                    () async {
                      final listQuotas = await advancepaymentHistory
                          .getPaymentFeesByPayment(payment.id ?? '');
                      await generateReceipt(
                        receiptNumber: paymentDate?.seconds.toString() ?? '',
                        date: paymentDateStr,
                        name: name,
                        dni: dni,
                        subtotal: amount - igv,
                        igv: igv,
                        total: amount,
                        typePay: textAdvancepayment,
                        storepay: listQuotas,
                      );
                      // advancepaymentHistory.getReceipt(
                      //   paymentDate?.seconds.toString() ?? '',
                      //   paymentDateStr,
                      //   fullName,
                      //   dni,
                      //   amount,
                      // );
                    },
                    '$amount',
                    'Pagado el $paymentDateStr',
                    false,
                    receiptNumber: paymentDate?.seconds.toString() ?? '',
                    date: paymentDateStr,
                    name: fullName,
                    dni: dni,
                    subtotal: amount,
                    typePay: textAdvancepayment,
                  );
                }))
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
