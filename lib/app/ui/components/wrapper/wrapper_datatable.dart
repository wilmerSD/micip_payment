import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class WrapperDatatable extends StatelessWidget {
  const WrapperDatatable(this.child, {super.key});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor(context),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      // color: Colors.amber,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(10.0),
        ),
        child: child,
      ),
    );
  }
}
