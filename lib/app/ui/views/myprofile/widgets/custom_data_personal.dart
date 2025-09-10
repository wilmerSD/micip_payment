import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDataPersonal extends StatelessWidget {
const CustomDataPersonal( this.child,{ super.key });

  final Widget child;
  @override
  Widget build(BuildContext context){
    return Container(
      
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor(context),
        boxShadow: [
            BoxShadow(
              color: AppColors.shadowAppBarColor(context),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 0), // changes position of shadow
            ),
        ],
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: child,
    );
  }
}