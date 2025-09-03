import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class OptionTypePay extends StatelessWidget {
  const OptionTypePay(
      {super.key,
      required this.text,
      required this.icon,
      required this.context,
      required this.colorBackIcon,
      required this.colorIcon,
      required this.ontap,
      required this.whatPlatformIs,
  });
  final String text;
  final IconData icon;
  final BuildContext context;
  final Color colorBackIcon;
  final Color colorIcon;
  final VoidCallback ontap;
  final int whatPlatformIs; // 0 for mobile, 1 for tablet, 2 for desktop

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: whatPlatformIs == 0 ? 150.0 : whatPlatformIs == 1 ? 200.0 : 225.0, // 150.0,
            height: whatPlatformIs == 0 ? 155.0 : whatPlatformIs == 1 ? 215.0 : 300.0, // 155.0,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: AppColors.cardColor(context),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.07),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 1),
                  ),
                ],
                borderRadius: BorderRadius.circular(5.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: whatPlatformIs == 0 ? 60.0 : whatPlatformIs == 1 ? 90.0 : 115.0,
                  height: whatPlatformIs == 0 ? 65.0 : whatPlatformIs == 1 ? 95.0 : 120.0,
                  decoration: BoxDecoration(
                      color: colorBackIcon,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Icon(
                    Bootstrap.calendar2_check,
                    color: colorIcon,
                    size: whatPlatformIs == 0 ? 20.0 : whatPlatformIs == 1 ? 40.0 : 40.0,
                  ),
                ),
                const Spacer(),
                SizedBox(
                    width: whatPlatformIs == 0 ? 140.0 : whatPlatformIs == 1 ? 140.0 : 140.0,
                    child: Text(
                      text,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.start,
                      style: AppTextStyle(context).textCard(),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
