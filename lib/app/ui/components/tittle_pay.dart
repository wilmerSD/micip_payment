import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class TittlePay extends StatelessWidget {
  const TittlePay(this.tittle, {super.key});

  final String tittle;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(tittle, style: AppTextStyle(context).textTittleContent()));
  }
}
