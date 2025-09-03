import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class BtnThird extends StatelessWidget {
  const BtnThird({
    super.key,
    required this.text,
    this.loading = false,
    this.onTap,
    this.isGreen = false,
    this.margin,
    this.showBoxShadow = true,
  });
  final String text;
  final bool loading;
  final bool? isGreen;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final bool showBoxShadow;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.5,
      margin: margin,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(kRadiusSmall),
        boxShadow: showBoxShadow
            ? [
                BoxShadow(
                  color: AppColors.red.withOpacity(0.25),
                  spreadRadius: 5,
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(kRadiusSmall),
          onTap: onTap,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textScaleFactor: 1,
                  text,
                  style: AppTextStyle(context)
                      .bold17(color: AppColors.backgroundColor(context)),
                ),
                loading
                    ? const Row(
                        children: [
                          SizedBox(
                            width: 30.0,
                          ),
                          SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
