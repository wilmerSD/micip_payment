import 'package:animate_do/animate_do.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';


class ToastMessage extends StatelessWidget {
  const ToastMessage(
      {super.key,
      required this.icon,
      required this.typeToast,
      required this.text});
  final String icon;
  final String typeToast;
  final String text;
  @override
  Widget build(BuildContext context) {
    return BounceInRight(
      animate: true,
      duration: const Duration(milliseconds: 100),
      child: Container(
        padding: const EdgeInsets.only(left: 15.0, right: 25.0),
        //   width: 280.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: typeToast == "success"
              ? AppColors.green
              : typeToast == "error"
                  ? Colors.red
                  : AppColors.primaryConst,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 209, 209, 209).withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // HelpersComponents.pathAssetIcons(icon, Colors.white),

            const SizedBox(
              width: 8.0,
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 12.0),
            ),
            // Row(
          ],
        ),
      ),
    );
  }

  // static String getErrorTitle(String text) {
  //   if (text.contains('NOT_INTERNET_EXCEPTION')) return 'Ooops!';

  //   switch (text) {
  //     case 'TIME_OUT':
  //       return 'Sin respuesta';
  //     case 'INVALID_TOKEN':
  //       return 'sesión expirada';
  //     case 'SERVER_ERROR':
  //       return 'Error';
  //     case 'REQUIRED':
  //       return 'Información';
  //     case 'DUPLICATE_KEY_ERROR':
  //       return messageErrorValRepeat;
  //     default:
  //       return 'Error';
  //   }
  // }
}
