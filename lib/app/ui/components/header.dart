import 'package:cip_payment_web/app/ui/components/tittle_pay.dart';
import 'package:cip_payment_web/core/helpers/responsive.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String tittle;
  final Widget options;

  const Header({super.key, required this.tittle, required this.options});

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context)
        ? Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: TittlePay(tittle)),
              Expanded(child: options),
              // Expanded(child: _automaticPay(context)),
              Expanded(child: SizedBox()),
            ],
          )
        : options;
  }
}
