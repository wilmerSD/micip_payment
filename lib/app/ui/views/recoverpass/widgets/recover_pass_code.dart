import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/components/fields/field_form.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/recoverpass_provider.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/widgets/custom_container.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/widgets/leading.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/widgets/text_back_login.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/widgets/text_tittle.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class RecoverPassCode extends StatelessWidget {
  const RecoverPassCode({super.key});

  @override
  Widget build(BuildContext context) {
    final recoverpassController = Provider.of<RecoverPassProvider>(context);

    /* 📌 Input de código de verificación */
    Widget inputCode = FieldForm(
      label: "Código de verificación",
      hintText: "123456",
      textInputType: TextInputType.emailAddress,
      textEditingController: recoverpassController.ctrlCodeVerification,
    );

    /* 📌 btn para enviar código de verificación */
    Widget btnSendCodeVerification = BtnPrimaryInk(
      text: recoverpassController.isLoading ? "Verificando..." : "Verificar",
      loading: recoverpassController.isLoading,
      onTap: () => context.go(
        '${AppRoutesName.RECOVERPASS}/${AppRoutesName.RECOVERPASSNEW}',)
    );

    Widget textSendCodeAgain = Center(
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: 'Enviar código nuevamente',
              style: AppTextStyle(context).bold14(
                fontWeight: FontWeight.w600,
                color: AppColors.quaternaryConst,
              ),
            ),
            TextSpan(
              text: ' 00:20',
              style: AppTextStyle(context).bold14(
                fontWeight: FontWeight.w600,
                color: AppColors.quaternaryConst,
              ),
            ),
          ],
        ),
      ),
    );

    Widget codeVerification = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: OtpTextField(
        borderWidth: 1.3,
        fieldWidth : 45,
        numberOfFields: 6,
        borderColor: AppColors.primaryConst,
        focusedBorderColor: AppColors.primaryConst,
        cursorColor: AppColors.primaryConst,
        showFieldAsBox: true,
        onCodeChanged: (String code) {
          // recoverpassController.ctrlCodeVerification.text = recoverpassController.ctrlCodeVerification.text + code;
        },
        onSubmit: (String verificationCode) {
          recoverpassController.ctrlCodeVerification.text = verificationCode;
          // recoverpassController.validateCode(context);
          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return AlertDialog(
          //       title: Text("Verification Code"),
          //       content: Text('Code entered is $verificationCode'),
          //     );
          //   },
          // );
        },
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(context),
      body: CustomContainer(
        content: Column(
          spacing: 20.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextTittle(
              tittle: 'Ingresar código',
              subTittle:
                  'Por favor ingrese el código que enviamos a su correo electrónico',
            ),
            codeVerification,
            btnSendCodeVerification,
            const Spacer(),
            const Center(child: TextBackLogin()),
          ],
        ),
      ),
    );
  }
}
