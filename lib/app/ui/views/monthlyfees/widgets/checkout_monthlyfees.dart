import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/components/fields/custom_text_field.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/monthlyfees_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutMonthlyfees extends StatelessWidget {
  const CheckoutMonthlyfees({super.key});

  @override
  Widget build(BuildContext context) {
    final monthlyfeesController = Provider.of<MonthlyfeesProvider>(context);

    /* 📌 Input cip del colegiado */
    Widget inputCardNumber = CustomTextField(
      helperText: 'Número de tarjeta',
      textEditingController: monthlyfeesController.ctrlCardNumber,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

    /* 📌 Input cip del colegiado */
    Widget inputCcv = CustomTextField(
      helperText: 'CCV',
      textEditingController: monthlyfeesController.ctrlCvv,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

    /* 📌 Input cip del colegiado */
    Widget inputCollege = CustomTextField(
      helperText: 'Mes de exp',
      textEditingController: monthlyfeesController.ctrlExpirationMonth,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

    /* 📌 Input cip del colegiado */
    Widget inputExpirationYear = CustomTextField(
      helperText: 'Año de exp',
      textEditingController: monthlyfeesController.ctrlExpirationYear,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

    /* 📌 Input cip del colegiado */
    Widget inputEmail = CustomTextField(
      helperText: 'Email',
      textEditingController: monthlyfeesController.ctrlEmail,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

    Widget btnPay = BtnPrimaryInk(text: 'Pagar S/. 30.0', onTap: () {
      monthlyfeesController.payMonthlyFeesv1(context);
      // monthlyfeesController.crearTokenCulqi();
      
    });

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      width: 900,
      child: Column(
        spacing: 10.0,
        children: [
          inputCardNumber,
          inputCcv,
          inputCollege,
          inputExpirationYear,
          inputEmail,
          const Spacer(),
          btnPay,
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
