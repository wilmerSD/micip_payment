import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class BtnPrimaryInk extends StatelessWidget {
  const BtnPrimaryInk({
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
      height: 50.0,
      margin: margin,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(kRadiusMedium),
        boxShadow: showBoxShadow
            ? [
                BoxShadow(
                  color: AppColors.red.withValues(),
                  spreadRadius: 0.5,
                  blurRadius: 6,
                  offset: const Offset(0, 0),
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(kRadiusMedium),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textScaler: TextScaler.linear(1),
                  text,
                  style: AppTextStyle(context)
                      .bold18(color: Colors.white),
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
