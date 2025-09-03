
import 'package:animate_do/animate_do.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSnackbar {
  static void showSnackBarCustom(
   BuildContext context, {
    required String title,
    required String message,
    required int type,
    required int time,
  }) {
    final overlay = Overlay.of(context);
    if (overlay == null) return;

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top +
            10, // Asegura que no tape la barra de estado
        left: 16,
        right: 16,
        child: FadeInDown(
          child: Material(
            color: const Color.fromARGB(0, 248, 195, 195),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: type == 1
                    ? AppColors.validationMissing
                    : type == 2
                        ? AppColors.validationJustified
                        : AppColors.validationTimely,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Ocultar el snackbar después de 2 segundos
    Future.delayed(Duration(seconds: time), () {
      overlayEntry.remove();
    });
  }
}
