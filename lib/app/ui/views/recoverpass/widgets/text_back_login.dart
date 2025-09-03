import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TextBackLogin extends StatelessWidget {
  const TextBackLogin({super.key});

  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      onTap: () => context.go(AppRoutesName.LOGIN),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: '¿Recordaste tu contraseña?',
              style: AppTextStyle(context).bold14(
                fontWeight: FontWeight.w500,
                color: AppColors.quaternaryConst,
              ),
            ),
            TextSpan(
              text: ' Acceder',
              style: AppTextStyle(context).bold14(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryConst,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
