import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class TextTittle extends StatelessWidget {
  TextTittle({
    super.key,
    required this.tittle,
    required this.subTittle,
  });
  String tittle;
  String subTittle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20.0,
      children: [
        Text(
          tittle,
          style: AppTextStyle(
            context,
          ).bold24(fontWeight: FontWeight.bold, color: AppColors.primaryConst),
        ),
        Text(
         subTittle ,
          style: AppTextStyle(context).bold14(
            fontWeight: FontWeight.w500,
            color: AppColors.quaternaryConst,
          ),
        ),
      ],
    );
  }
}
