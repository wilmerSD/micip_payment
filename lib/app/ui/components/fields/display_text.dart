import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DisplayText extends StatelessWidget {
  const DisplayText({
    super.key,
    this.label,
    this.hintText = "",
    this.privateText = false,
    this.suffix,
    this.onChanged,
    this.onEditingComplete,
    this.initialValue = "",
    this.enabledfield = false,
    this.textCapitalization,
    this.maxlines = 1,
    this.textEditingController,
    this.textInputType = TextInputType.text,
    this.autofocus = false,
    this.maxLength,
    this.inputFormats,
    this.helperText,
    required this.text,
  });
  final String? label;
  final String hintText;
  final bool privateText;
  final Widget? suffix;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final String? initialValue;
  final bool? enabledfield;
  final TextCapitalization? textCapitalization;
  final int? maxlines;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  final bool? autofocus;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormats;
  final String? helperText;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.0,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 3.0),
          child: Text(helperText ?? '',
              style: AppTextStyle(context).bold14(
                  color: AppColors.textBasic(context),
                  fontWeight: FontWeight.w500)),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: AppColors.grayLight,
              ),
              borderRadius: BorderRadius.circular(kRadiusExtraLittle),
              color: const Color.fromRGBO(246, 247, 249, 1),
            ),
            child: Text(
              text,
              style: AppTextStyle(context)
              .semi14(color: AppColors.textQuaternaryBasic(context))
            )),
      ],
    );
  }
}
