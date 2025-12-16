import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_primary.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_rounded.dart';
import 'package:cip_payment_web/app/ui/components/payment/payment_good_pdf.dart';
import 'package:cip_payment_web/core/helpers/helpers.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class PaymentGood extends StatelessWidget {
  const PaymentGood(
    this.operationId,
    this.amount,
    this.concept,
    this.typePay, {
    super.key,
  });

  final double amount;
  final String concept;
  final int operationId;
  final int typePay;

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final auth = context.read<AuthProvider>().currentPerson;
    final name = auth?.namePerson ?? '';
    final maternalSurname = auth?.motherSurname ?? '';
    final paternalSurname = auth?.paternalSurname ?? '';

    final dni = auth?.dni ?? '';
    final fullName = "$name $paternalSurname $maternalSurname";
    Color colorText = const Color.fromRGBO(90, 97, 111, 1);
    return SizedBox(
      // height: 530.0,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        width: 440.0,
        // height: 550,
        // margin: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          // color:  colorTheme.onInverseSurface,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 15.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 55.0,
              width: 55.0,
              child: Stack(
                children: [
                  Icon(Bootstrap.receipt_cutoff, size: 50, color: colorText),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      backgroundColor: colorTheme.onInverseSurface,
                      radius: 10,
                      child: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Listo, hicimos el pago correctamente',
              style: AppTextStyle(context).bold15(color: colorTheme.primary),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(width: 0.5, color: colorText),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.0,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Monto',
                          style: AppTextStyle(
                            context,
                          ).textPayment(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        // flex: 2,
                        child:
                            BtnRounded(Bootstrap.share, 'Compartir', () async {
                          final igv = amount * 0.18;
                          final file = await generatePdfToShare(
                            receiptNumber: operationId.toString(),
                            date: Helpers.formatCustomDate(
                                operationId), // tu helper
                            name: fullName,
                            dni: dni,
                            subtotal: amount - igv,
                            igv: igv,
                            total: amount,
                            typePay: concept,
                          );

                          // SharePlus.instance
                          //     .share(ShareParams(files: [XFile(file.path)]));
                        }),
                      ),
                    ],
                  ),
                  Text(
                    'S/. $amount',
                    style: AppTextStyle(context).textPayment(),
                  ),
                  Divider(color: colorText, thickness: 0.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [const Text('Concepto'), Text(concept)],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Igv'), Text('18%')],
                  ),
                  Divider(color: colorText, thickness: 0.5),
                  Center(
                    child: Column(
                      children: [
                        Text(Helpers.formatCustomDate(operationId)),
                        Text('Operación $operationId'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BtnPrimary(
                text: 'Finalizar',
                onTap: () {
                  switch (typePay) {
                    case 0:
                      Navigator.of(context).popUntil(
                          ModalRoute.withName(AppRoutesName.MONTHLYFEES));
                      break;
                    case 1:
                      Navigator.of(context).popUntil(
                          ModalRoute.withName(AppRoutesName.CERTIFICATESKILL));
                    case 2:
                      Navigator.of(context).popUntil(
                          ModalRoute.withName(AppRoutesName.PROOFNODEBT));
                    case 3:
                      Navigator.of(context).popUntil(
                          ModalRoute.withName(AppRoutesName.ADVANCEPAYMENT));
                      break;
                  }
                }),
          ],
        ),
      ),
    );
  }
}
