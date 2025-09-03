import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class Leading extends StatelessWidget {
  const Leading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15), 
      child: Center( 
        child: Material(
          color: const Color.fromRGBO(253, 231, 232, 1),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => Navigator.pop(context),
            child: const SizedBox(
              width: 40,
              height: 40,
              child: Icon(
                Bootstrap.arrow_left,
                // Icons.arrow_back,
                color: AppColors.quaternaryConst,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

