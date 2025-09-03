import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoAlertDialogComp extends StatelessWidget {
  final String tittle;
  final String textPrimaryButton;
  final String textSecondaryButton;
  final Widget? content;
  final VoidCallback onTapButton;
  final VoidCallback? onTapButtonSecondary;

  const CupertinoAlertDialogComp(
      {required this.tittle,
      this.textPrimaryButton = "Sí",
      this.textSecondaryButton = "No",
      required this.onTapButton,
      this.content,
      this.onTapButtonSecondary,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        tittle,
        style: AppTextStyle(context).bold14(
          color: Colors.black// AppColors.textBasic(context),
        ),
      ),
      content: content,
      actions: [
        TextButton(
          child: Text(textSecondaryButton,
              style: TextStyle(
                  color: AppColors.primaryConst,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0)),
          onPressed: () {
            (onTapButtonSecondary != null)
                ? onTapButtonSecondary!()
                : Navigator.of(context).pop();
          },
        ),
        TextButton(
            child: Text(textPrimaryButton,
                style: TextStyle(
                    color: AppColors.primaryConst,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0)),
            onPressed: () => onTapButton()),
      ],
    );
  }
}
