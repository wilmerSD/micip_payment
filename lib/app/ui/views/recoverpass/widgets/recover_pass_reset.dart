import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/components/field_form.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/recoverpass_provider.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/widgets/custom_container.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/widgets/leading.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/widgets/text_back_login.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/widgets/text_tittle.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class RecoverPassReset extends StatelessWidget {
  const RecoverPassReset({super.key});

  @override
  Widget build(BuildContext context) {
    final recoverpassController = Provider.of<RecoverPassProvider>(context);

      /* 📌 Input de password */
      Widget inputPass = FieldForm(
      label: "Nueva contraseña",
      hintText: "contraseña",
      privateText: recoverpassController.isVisiblePass,
      suffix: IconButton(
        onPressed: () {
          recoverpassController.isVisiblePass = !recoverpassController.isVisiblePass;
        },
        icon: Icon(
          recoverpassController.isVisiblePass
              ? Icons.visibility
              : Icons.visibility_off,
        ),
      ),
      textEditingController: recoverpassController.ctrlPassword,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

      /* 📌 Input password verificación */
      Widget inputSecondPass = FieldForm(
          label: "Repetir nueva contraseña",
          hintText: "repetir contraseña",
          privateText: recoverpassController.isVisiblePassRepeat,
          suffix: IconButton(
            onPressed: () {
             recoverpassController.isVisiblePassRepeat = !recoverpassController.isVisiblePassRepeat;
            },
            icon: Icon(
                recoverpassController.isVisiblePassRepeat ? Icons.visibility
              : Icons.visibility_off)
          ),
          textEditingController: recoverpassController.ctrlPasswordToConfirm,
        );

      /* 📌 btn para cambiar la contraseña */
      Widget btnChangePass = BtnPrimaryInk(
            text: recoverpassController.isLoading ? "Cambiando..." : "Cambiar contraseña",
            loading: recoverpassController.isLoading,
            onTap: () => {recoverpassController.validatePass(context)},
          );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(context),
      body: 
      CustomContainer(
        content: Column(
          spacing: 20.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextTittle(tittle: 'Restablecer contraseña',subTittle: 'Por favor escribe algo que recuerdes',),
            inputPass,
            inputSecondPass,
            btnChangePass,
            const Spacer(),
            const Center(child: TextBackLogin())
        ],),
      )
    );
  }
}
