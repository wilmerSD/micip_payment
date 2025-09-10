import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class BtnRounded extends StatelessWidget {
const BtnRounded(
  this.icon,
  this.text,
  this.onTap,
  { super.key });

  final IconData? icon;
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context){
    return InkWell(
    onTap: () => onTap(),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: AppColors.primaryConst)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10.0,
        children: [
          Icon(icon, color: AppColors.primaryConst,size: 15.0,),
          Text(
            text,
            style: AppTextStyle(context).bold14(color: AppColors.primaryConst),
          ),
        ],
      ),
    ),
  );
  }
}
