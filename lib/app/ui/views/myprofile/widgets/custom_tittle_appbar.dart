import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomTittleAppbar extends StatelessWidget {
  const CustomTittleAppbar({super.key, required this.tittle});
  final String tittle;
  @override
  Widget build(BuildContext context) {
    return Text(
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      tittle,
      style: AppTextStyle(context)
          .bold20(color: AppColors.textBasic(context)),
    );
  }
}
