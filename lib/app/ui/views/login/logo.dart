import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
const Logo({ super.key });

  @override
  Widget build(BuildContext context){
    return  Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8.0,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/LOGO_CIP.png'), // Reemplaza con tu imagen
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text('MiCIP',
                    style: AppTextStyle(context).bold30(
                        color: AppColors.primaryConst,
                        fontWeight: FontWeight.bold))
              ],
            );
  }
}