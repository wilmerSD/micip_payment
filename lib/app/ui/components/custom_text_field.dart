import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
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
      this.helperText});
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.0,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 3.0),
          child: Text(helperText ?? '', style: AppTextStyle(context).bold14(color: AppColors.textBasic(context),fontWeight: FontWeight.w500)),
        ),
        // const SizedBox(height: 8),
        TextField(
          enableSuggestions: true,
          inputFormatters: inputFormats,
          autofocus: autofocus ?? false,
          keyboardType: textInputType,
          maxLines: maxlines,
          readOnly: enabledfield!,
          controller: textEditingController,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          maxLength: maxLength,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          style: AppTextStyle(context).semi14(color: AppColors.textQuaternaryBasic(context)),
          obscureText: privateText,
          decoration: InputDecoration(
            fillColor: const Color.fromRGBO(246, 247, 249, 1),//AppColors.red,
            counterText: "",
            filled: true,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 13.0,
            ),
            //floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: suffix,
            suffixIconColor: AppColors.primaryConst,
            floatingLabelStyle: AppTextStyle(context).medium14(
              color: AppColors.grayBlue,
            ),
            labelStyle: AppTextStyle(context).medium14(
              color: AppColors.grayBlue,
            ),
            suffixStyle: AppTextStyle(context).medium14(
              color: AppColors.red,
            ),
            hintText: hintText,
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
        ),
      ],
    );
  }
}
