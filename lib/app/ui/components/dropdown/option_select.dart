import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OptionSelect extends StatelessWidget {
  const OptionSelect({super.key, this.nameOption});
  final String? nameOption;
  @override
  Widget build(BuildContext context) {
    return Text(nameOption ?? "",
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.grayDark,
        ));
  }
}
