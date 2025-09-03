import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.content});

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 40.0,
          bottom: 15.0,
        ),
        width: 400.0,
        height: 500.0,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor(context),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowAppBarColor(context),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: content,
      ),
    );
  }
}
