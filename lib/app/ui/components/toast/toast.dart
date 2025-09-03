import 'package:animate_do/animate_do.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class Toast extends StatelessWidget {
  const Toast(
      {super.key,
      required this.icon,
      required this.typeToast,
      required this.text});
  final int icon;
  final String typeToast;
  final String text;
  @override
  Widget build(BuildContext context) {
    return BounceInRight(
      animate: true,
      duration: const Duration(milliseconds: 100),
      child: Container(
        height: 70.0,
        width: 300.0,
        padding: const EdgeInsets.only(left: 15.0, right: 25.0),
        decoration: BoxDecoration(
          gradient: typeToast == "success"
              ? const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 76, 175, 80),
                    AppColors.green
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : typeToast == "error"
                  ? const LinearGradient(
                      colors: [
                        AppColors.red, // Color de inicio del degradado
                        AppColors
                            .red, // Color de final del degradado
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  : const LinearGradient(
                      colors: [
                        AppColors
                            .degradedInitial, // Color de inicio del degradado
                        AppColors.degradedInitial, // Color de final del degradado
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
          borderRadius: BorderRadius.circular(8.0),
          // boxShadow: [
          //   BoxShadow(
          //     color: AppColors.shadowAppBarColor(context),
          //     spreadRadius: 4,
          //     blurRadius: 5,
          //     offset: const Offset(0, 2), // changes position of shadow
          //   ),
          // ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          
          children: [
            Icon(icon == 0
                ? Bootstrap.check_circle_fill
                : icon == 1
                    ? Bootstrap.x_circle_fill
                    : icon == 2
                        ? Bootstrap.info_circle_fill
                        : Bootstrap.exclamation_triangle_fill,
                color: Colors.white),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Text(
                text,
                style: AppTextStyle(context).textToast(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showToastGlobal(BuildContext context, int icon, String type, String text) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 40,
      right: 24,
      child: Toast(icon: icon, typeToast: type, text: text),
    ),
  );

  overlay.insert(overlayEntry);
  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
