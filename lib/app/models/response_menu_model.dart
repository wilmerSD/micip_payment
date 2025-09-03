import 'package:flutter/material.dart';

class ResponseMenuOptionsModel {
  ResponseMenuOptionsModel(
      {this.route,
      this.nameOption,
      this.iconOption,
      this.isDesplegable,
      this.isActive,
      this.child,
      this.isDesplegated,
      this.isChild,
      this.isObscure = false,
      this.colors,
      this.onTap});

  String? route;
  String? nameOption;
  Widget? iconOption;
  bool? isActive;
  bool? isDesplegable;
  bool? isChild;
  bool? isDesplegated;
  bool? isObscure;
   Color? colors;
  Function()? onTap;

  List<ResponseMenuOptionsModel>? child;
}
