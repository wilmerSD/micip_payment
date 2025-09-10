import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class BtnPrimary extends StatelessWidget {
  const BtnPrimary({
    super.key,
    required this.text,
    this.loading = false,
    this.onTap,
    this.withIconProgress = true,
    this.margin,
    this.showBoxShadow = true,
  });
  final String text;
  final bool loading;
  final bool withIconProgress;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final bool showBoxShadow;
  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).disabledColor;
    return Container(
      height: 55.0,
      margin: margin,
      decoration: BoxDecoration(
        color: loading ? colorTheme : AppColors.primaryConst,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow:  [
          BoxShadow(
            color: loading
                ? colorTheme
                : AppColors.primaryConst.withValues(),
            spreadRadius: 0.5,
            blurRadius: 6,
            offset: const Offset(0, 0),
          ),
        ]
           
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: loading ? null : onTap,
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
                    ? Row(
                        children: [
                          SizedBox(
                            width: 30.0,
                          ),
                          withIconProgress  ?
                          SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ): SizedBox()
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
