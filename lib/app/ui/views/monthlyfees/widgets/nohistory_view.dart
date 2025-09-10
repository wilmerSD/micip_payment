import 'package:animate_do/animate_do.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NohistoryView extends StatelessWidget {
  const NohistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 250,
          width: 250,
          child: Lottie.asset('assets/nohistory_animation.json', repeat: false),
        ),

        FadeIn(
          duration: Duration(milliseconds: 1000),
          child: RichText(
            text: TextSpan(
              text: '',
              style: AppTextStyle(context).bold22(color: colorTheme.primary),
              children: [
                TextSpan(
                  text: 'Aun no tiene pagos registrados',
                  style: AppTextStyle(context).bold21(
                    fontWeight: FontWeight.w100,
                    color: colorTheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 100),
      ],
    );
  }
}
