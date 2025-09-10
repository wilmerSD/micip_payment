import 'package:cip_payment_web/app/ui/components/button/btn_primary.dart';
import 'package:cip_payment_web/app/ui/components/userlayout/user_layout.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class PaymentBad extends StatelessWidget {
  const PaymentBad(
    this.operationId,
    this.dateTime,
    this.detailError, {
    super.key,
  });

  final int operationId;
  final String dateTime;
  final String detailError;

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;

    final Color colorText = const Color.fromRGBO(90, 97, 111, 1);
    return UserLayout(
      true,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          width: 420.0,
          height: 550.0,
          decoration: BoxDecoration(
            color: colorTheme.onInverseSurface,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(            
            spacing: 15.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 55.0,
                width: 55.0,
                child: Stack(
                  children: [
                    Icon(Bootstrap.receipt_cutoff, size: 50, color: colorText),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        backgroundColor: colorTheme.onInverseSurface,
                        radius: 10,
                        child: Icon(
                          Bootstrap.x_circle_fill,
                          color: colorTheme.error,// Colors.red,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Lo sentimos, ocurrio un errror',
                style: AppTextStyle(context).bold15(color: colorTheme.primary),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(width: 0.5, color: colorText),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10.0,
                    children: [
                      Text(detailError, style: AppTextStyle(context).textPayment(),),
                      Divider(color: colorText, thickness: 0.5),
                      Spacer(),
                      Center(
                        child: Column(
                          children: [
                            Text(dateTime, style: AppTextStyle(context).textPayment(),),
                            Text('Operación $operationId',style: AppTextStyle(context).textPayment(),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Spacer(),
              BtnPrimary(text: 'Volver',),
            ],
          ),
        ),
      ),
    );
  }
}
