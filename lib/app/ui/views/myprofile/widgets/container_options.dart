import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class ContainerOptions extends StatelessWidget {
  const ContainerOptions(
    this.icon,
    this.text,
    this.ontap,
    this.iconRight, {
    super.key,
  });

  final Widget icon;
  final String text;
  final VoidCallback ontap;
  final IconData iconRight;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        height: 70.0,
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0 /*  vertical: 20.0 */,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color.fromARGB(92, 249, 249, 250),
          border: Border.all(color: const Color.fromRGBO(232, 242, 250, 1)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 10.0,
              children: [
                icon,
                Text(
                  text,
                  style: AppTextStyle(context).bold16(
                    // fontWeight: FontWeight.w500,
                    color: AppColors.textBasic(context),
                  ),
                ),
              ],
            ),
            Icon(iconRight),
          ],
        ),
      ),
    );
  }
}
