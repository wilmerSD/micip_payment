import 'package:cip_payment_web/app/ui/components/button/btn_primary.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_secondary.dart';
import 'package:cip_payment_web/app/ui/components/custom_text_field.dart';
import 'package:cip_payment_web/app/ui/components/modal_new_note.dart';
import 'package:cip_payment_web/app/ui/components/userlayout/user_layout.dart';
import 'package:cip_payment_web/app/ui/views/advancepayment/advancepayment_provider.dart';
import 'package:cip_payment_web/app/ui/views/advancepayment/widgets/datatable_advance_cuotas.dart';
import 'package:cip_payment_web/app/ui/views/advancepayment/widgets/detail_advance_cuotas.dart';
import 'package:cip_payment_web/app/ui/views/proofnodebt/proofnodebt_view.dart';
import 'package:cip_payment_web/core/helpers/responsive.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AdvancepaymentView extends StatelessWidget {
  const AdvancepaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    Widget btnCalculate = BtnSecondary(
      text: 'Calcular',
      onTap: () => ModalUtils.getShowModalBS(
        context,
        content: const DetailAdvanceCuotas(),
        title: 'Detalle de adelanto',
      ),
    );
    return UserLayout(true, child: customPyBeforev1(context));
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
  }
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

Widget _numberQuotas(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return CustomTextField(
    enabledfield: true,
    helperText: "Cantidad de cuotas",
    textInputType: TextInputType.emailAddress,
    textEditingController: advancepayment.ctrlQuantityCuotas,
  );
}

Widget _enabledUntilAdvancedPay(BuildContext context) {
  final advancepayment = Provider.of<AdvancepaymentProvider>(context);
  return CustomTextField(
    enabledfield: true,
    helperText: "Habilitado hasta",
    textInputType: TextInputType.emailAddress,
    textEditingController: advancepayment.ctrlEnabledUntil,
  );
}

Widget _firstPartAdvancePay(BuildContext context) {
  return Responsive.isDesktop(context) || Responsive.isTablet(context)
      ? Row(
          spacing: 30.0,
          children: [
            Expanded(child: _lastPay(context)),
            Expanded(child: _numberQuotas(context)),
            Expanded(child: _enabledUntilAdvancedPay(context)),
          ],
        )
      : Column(
          spacing: 12.0,
          children: [
            _lastPay(context),
            _numberQuotas(context),
            _enabledUntilAdvancedPay(context),
          ],
        );
}

Widget customPyBeforev1(BuildContext context) {
  return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            height: 150,
            width: 600,
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.backgroundColor(context),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.07),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              spacing: 15.0,
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Para poder ',
                        style: AppTextStyle(
                          context,
                        ).bold18(fontWeight: FontWeight.w300),
                      ),
                      TextSpan(
                        text: 'Adelantar cuotas ' ,
                        style: AppTextStyle(context).bold18(),
                      ),
                      TextSpan(
                        text: 'debe pagar sus cuotas pendientes',
                        style: AppTextStyle(
                          context,
                        ).bold18(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 15.0,
                  children: [
                    Expanded(child: SizedBox()),
                    Expanded(
                      child: BtnSecondary(
                        text: 'Volver',
                        onTap: () => context.go(AppRoutesName.HOME),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 47.0,
                        child: BtnPrimary(
                          text: 'Ir a pagar',
                          onTap: () =>
                              context.go(AppRoutesName.MONTHLYFEES),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}