import 'package:cip_payment_web/app/ui/components/button/btn_primary.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class WarningPay extends StatelessWidget {
  const WarningPay(this.text, {super.key});

  final String text;
  @override
  Widget build(BuildContext context) {
    final Color colorText = const Color.fromRGBO(90, 97, 111, 1);
    return Container(
      width: 450.0,
      padding: EdgeInsets.all(20.0),
      child: Column(
        spacing: 20.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 140.0,
            width: 140.0,
            child: Lottie.asset('assets/warning_animation.json'),
          ),
          Text(
            text,
            style: AppTextStyle(context).bold22(fontWeight: FontWeight.w100),
          ),
          SizedBox(height: 60.0),
          BtnPrimary(
            text: 'Ir a pagar',
            onTap: () => context.go(AppRoutesName.MONTHLYFEES),
          ),
          SizedBox(),
        ],
      ),
    );
  }
}
