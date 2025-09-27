import 'package:cip_payment_web/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_web/app/ui/components/bill/fields_bill.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_rounded.dart';
import 'package:cip_payment_web/app/ui/components/modal_new_note.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class SelectReceipt extends StatelessWidget {
  const SelectReceipt({
    super.key,
    required this.mainText,
    required this.textBtn,
    required this.textPopUp,
    required this.content,
  });
  final String mainText;
  final String textBtn;
  final String textPopUp;
  final Widget content;
  @override
  Widget build(BuildContext context) {
    Widget btnPay = BtnPrimaryInk(
      text: mainText,
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return PopupGeneral(
              onTapButton: () => {},
              title: textPopUp,
              content: content,
            );
                      // return isIos
                      //     ? CupertinoAlertDialogComp(
                      //         tittle: '¿Estás seguro(a) de cerrar sesión?',
                      //         onTapButton: () =>
                      //             Helpers.goToLoginRemoveUntil(context),
                      //       )
                      //     : AlertDialogComponent(
                      //         onTapButton: () => {},
                      //         title: "¿Estás seguro(a) de cerrar sesión?");
          },
        );
              // CheckoutMonthlyfees
        // monthlyfeesController.createToken(

        // );
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        spacing: 20.0,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '¿Necesitas factura?',
                style: AppTextStyle(context).bold15(),
              ),
              BtnRounded(null,'Solicitar', () {
                ModalUtils.getShowModalBS(
                  context,
                  content: FieldsBill(
                    textBtn: textBtn,
                    textPopUp: textPopUp,
                    content: content,
                  ),
                  title: 'Detalle de factura',
                );
              }),
            ],
          ),
          btnPay,
          const SizedBox(),
        ],
      ),
    );
  }
}
