import 'package:cip_payment_web/app/providers/bill_provider.dart';
import 'package:cip_payment_web/app/ui/components/bill/company_form.dart';
import 'package:cip_payment_web/app/ui/components/bill/fields_bill.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_rounded.dart';
import 'package:cip_payment_web/app/ui/components/modal_new_note.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectReceipt extends StatelessWidget {
  const SelectReceipt(
      {super.key,
      required this.onTap,
      required this.mainText,
      required this.textBtn,
      required this.textPopUp,
      required this.content});
  final void Function() onTap;
  final String mainText;
  final String textBtn;
  final String textPopUp;
  final Widget content;
  @override
  Widget build(BuildContext context) {
    Widget btnPay = BtnPrimaryInk(text: mainText, onTap: onTap);

    return ChangeNotifierProvider(
      create: (_) => BillProvider(),
      child: Builder(builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final billProvider =
              Provider.of<BillProvider>(context, listen: false);
          billProvider.onInit(context);
        });
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              spacing: 20.0,
              children: [
                Selector<BillProvider, bool>(
                  selector: (_, provider) => provider.isGettingRucs,
                  builder: (context, isGettingRucs, _) {
                    return isGettingRucs
                        ? const CircularProgressIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '¿Necesitas factura?',
                                style: AppTextStyle(context).bold15(),
                              ),
                              BtnRounded(null, 'Solicitar', () {
                                // print(context.read<BillProvider>().listCompanies.length);
                                // ModalUtils.getShowModalBS(
                                //   context,
                                //   content: ChangeNotifierProvider.value(
                                //     value: context.read<BillProvider>(),
                                //     child: Consumer<BillProvider>(
                                //       builder: (context, provider, _) {
                                //         print(provider.listCompanies.length);
                                //         return provider.listCompanies.isEmpty
                                //             ? const CompanyForm(
                                //                 'Guardar', true, true)
                                //             : FieldsBill(
                                //                 textBtn: textBtn,
                                //                 textPopUp: textPopUp,
                                //                 content: content,
                                //                 onTap: onTap,
                                //               );
                                //       },
                                //     ),
                                //   ),
                                //   title: 'Detalle de factura',
                                // );
                                // Navigator.of(context).pop();
                                context
                                        .read<BillProvider>()
                                        .listCompanies
                                        .isNotEmpty
                                    ? ModalUtils.getShowModalBS(
                                        context,
                                        content: ChangeNotifierProvider.value(
                                            value: context.read<BillProvider>(),
                                            child: FieldsBill(
                                              textBtn: textBtn,
                                              textPopUp: textPopUp,
                                              content: content,
                                              onTap: onTap,
                                            )),
                                        title: 'Detalle de factura',
                                      )
                                    : ModalUtils.getShowModalBS(
                                        context,
                                        content: ChangeNotifierProvider.value(
                                            value: context.read<BillProvider>(),
                                            child: const CompanyForm(
                                                'Guardar', true, true)),
                                        title: 'Detalle de factura',
                                      );
                              })
                            ],
                          );
                  },
                ),
                btnPay,
              ],
            ),
          ),
        );
      }),
    );
  }
}
