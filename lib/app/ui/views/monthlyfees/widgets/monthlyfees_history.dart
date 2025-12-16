import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/app/ui/components/payment_tile.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/monthlyfees_provider.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/widgets/nohistory_view.dart';
import 'package:cip_payment_web/core/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyfeesHistory extends StatelessWidget {
  const MonthlyfeesHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>().currentPerson;
    final name = auth?.namePerson ?? '';
    final maternalSurname = auth?.motherSurname ?? '';
    final paternalSurname = auth?.paternalSurname ?? '';
    final dni = auth?.dni ?? '';
    final fullName = "$name $paternalSurname $maternalSurname";

    return context.read<MonthlyfeesProvider>().paymentHistoryQuotas.isEmpty
        ? const NohistoryView()
        : ListView(
            children: [
              Consumer<MonthlyfeesProvider>(
                builder: (context, provider, _) {
                  return SingleChildScrollView(
                    child: Wrap(
                      spacing: 30.0,
                      runSpacing: 10.0,
                      children:
                          List.generate(provider.paymentHistoryQuotas.length, (
                        index,
                      ) {
                        final payment = provider.paymentHistoryQuotas[index];

                        final paymentDate = payment.creationDatePay;
                        final paymentDateStr =
                            Helpers.timestampToString(paymentDate);
                        final amount = payment.paymentValue?.toDouble() ?? 0.0;
                        print('cuantas veces hace esto');

                        return PaymentTile(
                            Helpers.formatDateFromTimestamp(paymentDate),
                            Helpers.typePay(payment.receiptType), () async {
                          await provider
                              .getPaymentFeesByPayment(payment.id ?? '');
                          provider.getReceipt(
                            paymentDate?.seconds.toString() ?? '',
                            paymentDateStr,
                            fullName,
                            dni,
                            amount,
                          );
                        }, 'S/.$amount', 'Pagado el $paymentDateStr', false);
                      }),
                    ),
                  );
                },
              ),
            ],
          );
  }
}
