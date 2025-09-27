import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_secondary.dart';
import 'package:cip_payment_web/app/ui/components/fields/custom_text_field.dart';
import 'package:cip_payment_web/app/ui/components/modal_new_note.dart';
import 'package:cip_payment_web/app/ui/components/userlayout/user_layout.dart';
import 'package:cip_payment_web/app/ui/views/advancepayment/advancepayment_provider.dart';
import 'package:cip_payment_web/app/ui/views/advancepayment/widgets/detail_advance_cuotas.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/widgets/custom_data_personal.dart';
import 'package:cip_payment_web/core/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdvancepaymentView extends StatelessWidget {
  const AdvancepaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    print('Adelanto de cuotas');
    final colorTheme = Theme.of(context).colorScheme;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final advancepaymentProvider = Provider.of<AdvancepaymentProvider>(
        context,
        listen: false,
      );
      advancepaymentProvider.onInit(context);
    });

    // return UserLayout(true, child: customPyBeforev1(context));
    // return UserLayout(
    //   true,
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 15.0),
    //     child: Column(
    //       spacing: 12.0,
    //       children: [
    //         _firstPartAdvancePay(context),
    //         const SizedBox(),
    //         const Expanded(
    //           child: ClipRRect(
    //             borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(10),
    //               topRight: Radius.circular(10),
    //             ),
    //             child: DatatableAdvanceCuotas(),
    //           ),
    //         ),
    //         SizedBox(width: 400.0, child: btnCalculate),
    //         const SizedBox(height: 15.0),
    //       ],
    //     ),
    //   ),
    // );
    return UserLayout(
      true,
      child: Row(
        spacing: 30.0,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: colorTheme
                    .onInverseSurface, // const Color.fromRGBO(227, 30, 36, 0.3),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                spacing: 20.0,
                children: [
                  valueOfQuota(context),
                  discuount(context),
                  enabledUntilAdvancedPay(context),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomDataPersonal(
              Column(
                spacing: 20.0,
                children: [
                  numberQuotas(context),
                  wouldBeEnabledUntil(context),
                  subTotal(context),
                  saveMoney(context),
                  Spacer(),
                  payAdvance(context),
                  SizedBox(height: 0.0,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget valueOfQuota(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return CustomTextField(
    enabledfield: true,
    helperText: 'Valor de la cuota',
    textInputType: TextInputType.emailAddress,
    textEditingController: advancepayment.ctrlValueOfQuota,
  );
}

Widget discuount(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return CustomTextField(
    enabledfield: true,
    helperText: 'Descuento',
    textInputType: TextInputType.emailAddress,
    textEditingController: advancepayment.ctrlPercentDiscount,
  );
}

Widget enabledUntilAdvancedPay(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return CustomTextField(
    enabledfield: true,
    helperText: "Habilitado hasta",
    textInputType: TextInputType.emailAddress,
    textEditingController: advancepayment.ctrlEnabledUntil,
  );
}


Widget numberQuotas(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return CustomTextField(
    helperText: "Cantidad de cuotas",
    textInputType: TextInputType.number,
    textEditingController: advancepayment.ctrlQuantityCuotas,
    onChanged:(_) => advancepayment.calculateToPay()
  );
}

Widget wouldBeEnabledUntil(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return CustomTextField(
    enabledfield: true,
    helperText: "Tu habilitación cubre hasta",
    textInputType: TextInputType.emailAddress,
    textEditingController: advancepayment.ctrlEnabledUntil,
  );
}

Widget subTotal(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return CustomTextField(
    enabledfield: true,
    helperText: "Sub total",
    textInputType: TextInputType.emailAddress,
    textEditingController: advancepayment.ctrlSubTotal,
  );
}

Widget saveMoney(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return CustomTextField(
    enabledfield: true,
    helperText: "Ahorras",
    textInputType: TextInputType.emailAddress,
    textEditingController: advancepayment.ctrlDiscount,
  );
}

Widget payAdvance(BuildContext context) {
  return SizedBox(
    width: 400.0,
    child: BtnPrimaryInk(
      text: 'Pagar S/. ${context.read<AdvancepaymentProvider>().totalToPay}',
    ),
  );
}

Widget _lastPay(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return CustomTextField(
    enabledfield: true,
    helperText: 'Ultimo pago',
    textInputType: TextInputType.emailAddress,
    textEditingController: advancepayment.ctrlLastPay,
  );
}



// Widget _firstPartAdvancePay(BuildContext context) {
//   return Responsive.isDesktop(context) || Responsive.isTablet(context)
//       ? Row(
//           spacing: 30.0,
//           children: [
//             Expanded(child: _lastPay(context)),
//             Expanded(child: _numberQuotas(context)),
//             Expanded(child: _enabledUntilAdvancedPay(context)),
//           ],
//         )
//       : Column(
//           spacing: 12.0,
//           children: [
//             _lastPay(context),
//             _numberQuotas(context),
//             _enabledUntilAdvancedPay(context),
//           ],
//         );
// }

Widget customPyBeforev1(BuildContext context) {
  return Container();
}


