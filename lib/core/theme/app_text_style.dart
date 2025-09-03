// ignore_for_file: dead_code
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle(this.context);
  final BuildContext context;

  TextStyle titleAppBar({
    Color color = AppColors.grayLight,
  }) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color, fontWeight: FontWeight.bold, fontFamily: 'Montserrat');

  TextStyle bold45(
          {Color color = Colors.black,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 45.0,
          fontFamily: 'Montserrat');
  TextStyle bold30(
          {Color color = Colors.black,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 30.0,
          fontFamily: 'Montserrat');

  TextStyle bold26(
          {Color color = Colors.black,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 26.0,
          fontFamily: 'Montserrat');

  TextStyle bold24(
          {Color color = Colors.black,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 24.0,
          fontFamily: 'Montserrat');
  TextStyle bold23(
          {Color color = Colors.black,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 23.0,
          fontFamily: 'Montserrat');
  TextStyle bold22(
          {Color color = Colors.black,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 22.0,
          fontFamily: 'Montserrat');
  TextStyle bold21(
          {Color color = Colors.black,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 21.0,
          fontFamily: 'Montserrat');
  TextStyle bold20(
          {Color color = Colors.black,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 20.0,
          fontFamily: 'Montserrat');
  TextStyle bold19(
          {Color? color = Colors.black,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 19.0,
          fontFamily: 'Montserrat');
  TextStyle bold18(
          {Color? color = Colors.black,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 18.0,
          fontFamily: 'Montserrat');

  TextStyle bold17(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 17.0,
          fontFamily: 'Montserrat');

  TextStyle bold16(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 16.0,
          fontFamily: 'Montserrat');

  TextStyle bold15(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 15.0,
          fontFamily: 'Montserrat');

  TextStyle bold14(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 14.0,
          fontFamily: 'Montserrat');
  TextStyle bold13(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 13.0,
          fontFamily: 'Montserrat');
    TextStyle bold12(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 12.0,
          fontFamily: 'Montserrat');

    TextStyle bold11(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 11.0,
          fontFamily: 'Montserrat');
    TextStyle bold10(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 10.0,
          fontFamily: 'Montserrat');

  TextStyle semi14({
    Color color = AppColors.grayLight,
  }) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: FontWeight.w500,
          fontSize: 14.0,
          fontFamily: 'Montserrat');

  TextStyle medium14({
    Color color = AppColors.grayLight,
  }) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
          fontFamily: 'Montserrat');

  TextStyle medium12({
    Color color = AppColors.grayLight,
  }) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: FontWeight.w400,
          fontSize: 12.0,
          fontFamily: 'Montserrat');

  TextStyle extra20({Color? color = Colors.black}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          fontFamily: 'Montserrat');

  TextStyle extra22({Color? color = Colors.black}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: color,
            fontWeight: FontWeight.w900,
            fontSize: 22.0,
          );

  TextStyle extra14({Color? color = Colors.black}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: color,
            fontWeight: FontWeight.w300,
            fontSize: 14.0,
          );

  TextStyle extra16({Color? color = Colors.black}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
          fontFamily: 'Montserrat');

  TextStyle regular14(
          {Color? color = AppColors.grayBlue, double size = 14}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color, fontWeight: FontWeight.normal, fontSize: size);
  TextStyle extra40({
    Color? color = Colors.black,
  }) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
            fontFamily: 'Montserrat',
          );
  
  //Textos
  TextStyle textGeneral({
    Color? color
  })=> Theme.of(context).textTheme.bodyLarge!.copyWith(
    color: color ?? AppColors.textBasic(context),
    fontWeight: FontWeight.w300,
    fontSize: 15,
    fontFamily: 'Montserrat'
  );

  TextStyle textCard({
    Color? color,
  })=>Theme.of(context).textTheme.bodyMedium!.copyWith(
    color: color ?? AppColors.textCardColor(context),
    fontWeight: FontWeight.w300,
    fontSize: 22.0,
    fontFamily: 'Montserrat'
  );

  TextStyle textHeaderRightMain({
    Color? color,
  })=>Theme.of(context).textTheme.bodyMedium!.copyWith(
    color: color ?? AppColors.textBasic(context),
    fontWeight: FontWeight.w700,
    fontSize: 14.0,
    fontFamily: 'Montserrat'
  );

  TextStyle textHeaderRightSec({
    Color? color,
  })=>Theme.of(context).textTheme.bodySmall!.copyWith(
    color: color ?? AppColors.textBasic(context),
    fontWeight: FontWeight.w100,
    fontSize: 13.0,
    fontFamily: 'Montserrat'
  );

  TextStyle textTittleContent({
    Color? color,
  })=>Theme.of(context).textTheme.bodyMedium!.copyWith(
    color: color ?? AppColors.textTittleContent(context),
    fontWeight: FontWeight.w700,
    fontSize: 24.0,
    fontFamily: 'Montserrat'
  );

  TextStyle textToast({
    Color? color,
  })=>Theme.of(context).textTheme.bodyMedium!.copyWith(
    color: color ?? Colors.white,//AppColors.textTittleContent(context),
    fontWeight: FontWeight.w400,
    fontSize: 13.0,
    fontFamily: 'Montserrat'
  );
}
