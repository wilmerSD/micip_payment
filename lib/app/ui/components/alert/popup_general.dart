import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class PopupGeneral extends StatelessWidget {
  final String title;
  final double borderRadius; // Nuevo parámetro para ajustar el radio
  final TextStyle? titleStyle; // Estilo del título
  final TextStyle? optionStyle; // Estilo de las opciones
  final VoidCallback onTapButton;
  final Widget content;
  final bool scrollable;

  const PopupGeneral({
    super.key,
    required this.title,
    required this.onTapButton,
    this.borderRadius = 8.0, // Valor predeterminado
    this.titleStyle,
    this.optionStyle,
    required this.content,
    this.scrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.backgroundColor(context),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 30.0,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
      scrollable: scrollable,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      title: title.isEmpty
          ? null
          : Text(
              title,
              style:
                  titleStyle ??
                  AppTextStyle(context).bold26(color: AppColors.primaryConst),
            ),
      content: content,
    );
  }
}
