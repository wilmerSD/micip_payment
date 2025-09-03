import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/monthlyfees_provider.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class AutomaticPay extends StatelessWidget {
  const AutomaticPay({super.key});

  @override
  Widget build(BuildContext context) {

      Widget button = BtnPrimaryInk(
      // loading: loginController.isAuthenticating,
      text:  'Afiliar pagos',
      onTap: () {
        // loginController. getLogin(context); 
        // loginController.authentication(context);
      },
      /*onTap: () =>  controller.validateForm(context) */
    );

    Widget termsAndCoditions = RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Al continuar, aceptas nuestros ',
               style: AppTextStyle(context).bold10(color: AppColors.quaternaryConst),
              ),
              TextSpan(
                text: 'Términos y Condiciones',
                style: AppTextStyle(context).bold10(color: AppColors.granateConst),
              ),
            ],
          ),
        );

    return ChangeNotifierProvider(
        create: (_) => MonthlyfeesProvider(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.backgroundColor(context),
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor(context),
            title: const Text('Débito automatico'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              spacing: 10.0,
              children: [
                const SizedBox(),
                Text(
                  'Configura el pago automático y despreocúpate de pagar cada mes.',
                  style: AppTextStyle(context).bold14(),
                ),
                const SizedBox(),
                _customContainer(Bootstrap.calendar,
                    'El débito se realizará a los 15 días despues de generado el recibo'),
                _customContainer(Bootstrap.chat_left_text,
                    'Te mantendremos informado de medio de un SMS cada vez que se realice el pago de tu recibo.'),
                _customContainer(Bootstrap.phone_vibrate,
                    'En caso tu tarjeta sea rechazada por tu banco o financiera, te alergtaremos por medio de un sms.'),
                _customContainer(Bootstrap.file_earmark_check,
                    'En caso quieras modificar tu afiliación, puedes cancelarlos desde aqui.'),
                const Spacer(),
                button,
                termsAndCoditions,
                const SizedBox(height: 20.0,)
              ],
            ),
          ),
        ));
  }
}

Widget _customContainer(IconData icon, String text) {
  return Container(
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15.0,
      children: [Column(
        spacing: 3.0,
        children: [
          SizedBox(),
          Icon(icon),
        ],
      ), Expanded(child: Text(text))],
    ),
  );
}
