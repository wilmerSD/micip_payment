import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/components/custom_data_right.dart';
import 'package:cip_payment_web/app/ui/components/fields/custom_text_field.dart';
import 'package:cip_payment_web/app/ui/components/fields/read_only_field.dart';
import 'package:cip_payment_web/app/ui/components/modal_new_note.dart';
import 'package:cip_payment_web/app/ui/components/reciept/select_receipt.dart';
import 'package:cip_payment_web/app/ui/views/advancepayment/advancepayment_provider.dart';
import 'package:cip_payment_web/core/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AdvancepaymentPay extends StatelessWidget {
  const AdvancepaymentPay({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsetsGeometry.all(15),
      child: Responsive.isDesktop(context)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 15.0,
              children: [
                Expanded(
                  child: Row(
                    spacing: 20.0,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          // height: 200,
                          // width: 300,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: colorTheme
                                .onInverseSurface, // const Color.fromRGBO(227, 30, 36, 0.3),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            spacing: 10.0,
                            children: [
                              Row(
                                spacing: 15.0,
                                children: [
                                  Expanded(child: valueOfQuota(context)),
                                  Expanded(child: discuount(context)),
                                ],
                              ),
                              enabledUntilAdvancedPay(context),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        // height: 200,
                        // width: 300,
                        child: CustomDataRight(
                          SizedBox(
                            // height: 200,
                            child: Column(
                              children: [
                                const SizedBox(height: 10.0),
                                numberQuotas(context),
                                const SizedBox(height: 20.0),
                                wouldBeEnabledUntil(context),
                                const SizedBox(height: 20.0),
                                Row(
                                  spacing: 15.0,
                                  children: [
                                    Expanded(child: subTotal(context)),
                                    // const SizedBox(
                                    //   height: 20.0,
                                    // ),
                                    Expanded(child: saveMoney(context)),
                                    // const SizedBox(
                                    //   height: 10.0,
                                    // ),
                                  ],
                                ),
                                Spacer(),
                                payAdvance(context),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // payAdvance(context)
              ],
            )
          : Column(
              spacing: 20.0,
              children: [
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: colorTheme
                        .onInverseSurface, // const Color.fromRGBO(227, 30, 36, 0.3),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    spacing: 10.0,
                    children: [
                      Row(
                        spacing: 15.0,
                        children: [
                          Expanded(child: valueOfQuota(context)),
                          Expanded(child: discuount(context)),
                        ],
                      ),
                      enabledUntilAdvancedPay(context),
                    ],
                  ),
                ),
                Expanded(
                  child: CustomDataRight(
                    SizedBox(
                      // height: 200,
                      child: ListView(
                        children: [
                          const SizedBox(height: 10.0),
                          numberQuotas(context),
                          const SizedBox(height: 20.0),
                          wouldBeEnabledUntil(context),
                          const SizedBox(height: 20.0),
                          Row(
                            spacing: 15.0,
                            children: [
                              Expanded(child: subTotal(context)),
                              // const SizedBox(
                              //   height: 20.0,
                              // ),
                              Expanded(child: saveMoney(context)),
                              // const SizedBox(
                              //   height: 10.0,
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                payAdvance(context),
                // const SizedBox()
              ],
            ),
    );
  }
}

Widget valueOfQuota(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return ReadOnlyField(
    label: 'Valor de la cuota',
    value: advancepayment.ctrlValueOfQuota,
  );
}

Widget discuount(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return ReadOnlyField(
    label: 'Descuento',
    value: advancepayment.ctrlPercentDiscount,
  );
}

Widget enabledUntilAdvancedPay(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return ReadOnlyField(
    label: "Habilitado hasta",
    value: advancepayment.enabledUntil,
  );
}

Widget numberQuotas(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return CustomTextField(
    helperText: "Cantidad de cuotas",
    textInputType: TextInputType.number,
    textEditingController: advancepayment.ctrlQuantityCuotas,
    inputFormats: [
      FilteringTextInputFormatter.digitsOnly, // ✅ Solo permite números
    ],
    onChanged: (_) => advancepayment.calculateToPay(),
  );
}

Widget wouldBeEnabledUntil(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return ReadOnlyField(
    label: "Tu habilitación cubre hasta",
    value: advancepayment.wouldEnableUntil,
  );
}

Widget subTotal(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return ReadOnlyField(label: "Sub total", value: advancepayment.ctrlSubTotal);
}

Widget saveMoney(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return ReadOnlyField(label: "Ahorras", value: advancepayment.ctrlDiscount);
}

Widget payAdvance(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return SizedBox(
    width: 400.0,
    child: BtnPrimaryInk(
      withIconProgress: false,
      loading:
          advancepayment.totalToPay == 0 ||
          advancepayment.stateCollegiate == false,
      text: 'Pagar S/. ${advancepayment.totalToPay}',
      onTap: () {
        ModalUtils.getShowModalBS(
          context,
          content: SelectReceipt(
            mainText: 'Pagar S/. ${advancepayment.totalToPay}',
            textBtn: 'Pagar S/. ${advancepayment.totalToPay}',
            textPopUp: 'Pagar certificado de habilidad',
            content: const SizedBox(),
            onTap: () {
              advancepayment.openCheckout(
                context,
                context.read<AuthProvider>().currentPerson,
              );
            },
          ),
          title: 'Detalle de pago',
        );
      },
    ),
  );
}
