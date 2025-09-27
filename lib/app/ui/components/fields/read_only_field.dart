import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class ReadOnlyField extends StatelessWidget {
  const ReadOnlyField({super.key, required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle(context).bold14(
            color: AppColors.textBasic(context),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        InputDecorator(
          // fillColor
          decoration: InputDecoration(
            fillColor: AppColors.fillTextColor(context),// const Color.fromRGBO(246, 247, 249, 1),
            counterText: "",
            filled: true,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 13.0,
            ),
            suffixIconColor: AppColors.primaryConst,
            floatingLabelStyle: AppTextStyle(context).medium14(
              color: AppColors.grayBlue,
            ),
            // labelStyle: AppTextStyle(context).medium14(
            //   color: const Color.fromARGB(255, 11, 29, 227),
            // ),
            suffixStyle: AppTextStyle(context).medium14(
              color: AppColors.red,
            ),
            // hintText: hintText,
            hintStyle: AppTextStyle(context).medium14(
              color: AppColors.grayBlue,
            ),
            // labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kRadiusExtraLittle),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kRadiusExtraLittle),
              borderSide: const BorderSide(
                width: 1.0,
                color: AppColors.grayLight,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kRadiusExtraLittle),
              borderSide: const BorderSide(
                width: .5,
                color: AppColors.primaryConst,
              ),
            ),
          ),
          child: Text(
            value,
            style: AppTextStyle(
              context,
            ).semi14(color: AppColors.textQuaternaryBasic(context)),
          ),
        ),
      ],
    );
  }
}
