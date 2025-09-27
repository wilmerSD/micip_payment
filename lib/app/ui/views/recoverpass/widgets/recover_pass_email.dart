import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/components/fields/field_form.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/recoverpass_provider.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/widgets/custom_container.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/widgets/text_back_login.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/widgets/text_tittle.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RecoverPasswordEmail extends StatelessWidget {
  const RecoverPasswordEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final recoverpassController = Provider.of<RecoverPassProvider>(context);

    /* 📌 Input de email */
    Widget inputEmail = FieldForm(
      label: "Email",
      hintText: "Ingrese correo email",
      textInputType: TextInputType.emailAddress,
      textEditingController: recoverpassController.ctrlEmail,
    );

    /* 📌 btn para enviar código de verificación */
    Widget getCodeVerification = BtnPrimaryInk(
      text: recoverpassController.isLoading ? "Enviando..." : "Obtener código",
      loading: recoverpassController.isLoading,
      onTap: () => context.go(
        '${AppRoutesName.RECOVERPASS}/${AppRoutesName.RECOVERPASSCODE}',
      ),
    );

    Widget backLogin = Column(
      children: [
        InkWell(
          onTap: () => recoverpassController.goToLogin(context),
          child: const Center(child: TextBackLogin()),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(context),
      // appBar: AppBar(leading: const Leading()),
      body: CustomContainer(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20.0,
          children: [
            TextTittle(
              tittle: '¿Olvidaste tu contraseña',
              subTittle:
                  'No te preocupes, eso pasa. Por favor, ingrese su email asociado con su cuenta',
            ),
            inputEmail,
            getCodeVerification,
            const Spacer(),
            backLogin,
          ],
        ),
      ),
    );
  }
}
