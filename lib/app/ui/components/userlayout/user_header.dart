import 'package:cip_payment_web/app/ui/components/userlayout/popup_header.dart';
import 'package:cip_payment_web/app/ui/views/login/logo.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class UserHeader extends StatelessWidget {
  final String userName;
  final String cipNumber;
  final String avatarUrl;

  const UserHeader({
    super.key,
    required this.userName,
    required this.cipNumber,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.headerColor(context),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowAppBarColor(context),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Logo(),
          // Usuario
          Row(
            children: [
              Column(
                spacing: 5.0,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Hola, $userName",
                    style: AppTextStyle(context).textHeaderRightMain(),
                  ),
                  Text(
                    "N° CIP:$cipNumber",
                    style: AppTextStyle(context).textHeaderRightSec(),
                  ),
                ],
              ),
              const SizedBox(width: kSizeSmallLittle),
              SizedBox(height: 60, width: 60, child: PopupMenuExample()),
            ],
          ),
        ],
      ),
    );
  }
}
