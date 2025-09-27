import 'package:cip_payment_web/app/ui/components/button/btn_primary.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_secondary.dart';
import 'package:cip_payment_web/app/ui/components/fields/read_only_field.dart';
import 'package:cip_payment_web/app/ui/components/tittle_pay.dart';
import 'package:cip_payment_web/app/ui/components/userlayout/user_layout.dart';
import 'package:cip_payment_web/app/ui/views/proofnodebt/proofnodebt_provider.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/helpers/responsive.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProofnodebtView extends StatelessWidget {
  const ProofnodebtView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProofnodebtProvider(),
      child: Builder(
        builder: (context) {
          return UserLayout(
            true,
            child: customPyBefore(context, 'constancia de no adeudo '),
          );
        },
      ),
    );
  }
}

Widget customPyBefore(BuildContext context, String text) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final proofnodebtProvider = Provider.of<ProofnodebtProvider>(
      context,
      listen: false,
    );
    proofnodebtProvider.onInit(context);
  });
  return Responsive.isMobile(context)
      ? Container(
          // color: Colors.amber,
          child: Column(
            spacing: 20.0,
            children: [
              TittlePay(textProofnodebt),
              _textFieldCip(),
              _textFieldCollege(),
              _textFieldState(),
              _textFieldEnabledUntil(),
              Spacer(),
              _btnPay(),
            ],
          ),
        )
      : Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20.0,
          children: [
            TittlePay(textProofnodebt),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 800.0),
              child: Row(
                spacing: 20.0,
                children: [
                  Expanded(child: _textFieldCip()),
                  Expanded(child: _textFieldCollege()),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 800.0),
              child: Row(
                spacing: 20.0,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: _textFieldState()),
                  Expanded(child: _textFieldEnabledUntil()),
                ],
              ),
            ),
            Spacer(),
            _btnPay(),
          ],
        );
}

Widget _textFieldCip() {
  return ReadOnlyField(label: 'Cip', value: '123342341413');
}

Widget _textFieldCollege() {
  return ReadOnlyField(label: 'Colegiado', value: '123342341413');
}

Widget _textFieldState() {
  return ReadOnlyField(label: 'Estado', value: '123342341413');
}

Widget _textFieldEnabledUntil() {
  return ReadOnlyField(label: 'Habilitado hasta', value: '123342341413');
}

Widget _btnPay() {
  return SizedBox(width: 400.0, child: BtnPrimary(text: 'Pagar'));
}
