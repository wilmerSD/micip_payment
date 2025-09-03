import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class BtnSecondary extends StatelessWidget {
  const BtnSecondary(
      {super.key,
      required this.text,
      this.onTap,
      this.borderColor,
      this.textColor});
  final String text;
  final void Function()? onTap;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      // padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(kRadiusSmall),
          border: Border.all(color: borderColor ?? AppColors.primaryConst, width: 2)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          // highlightColor: const Color.fromARGB(34, 227, 30, 37),
          borderRadius: BorderRadius.circular(8.0),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9.0),
            child: Center(
              child: Text(text,
                  style: AppTextStyle(context).bold17(color: AppColors.primaryConst), overflow: TextOverflow.ellipsis,),
            ),
          ),
        ),
      ),
    );
  }
}
