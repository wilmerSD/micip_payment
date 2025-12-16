import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/components/fields/field_form.dart';
import 'package:cip_payment_web/app/ui/components/userlayout/user_layout.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/myprofile_provider.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/widgets/custom_container.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPass extends StatelessWidget {
  const ResetPass({super.key});

  @override
  Widget build(BuildContext context) {
    final recoverpassController = Provider.of<MyprofileProvider>(context);

    /* 📌 Input de password */
    Widget inputPass = FieldForm(
      label: "Nueva contraseña",
      hintText: "contraseña",
      privateText: recoverpassController.isVisiblePass,
      suffix: IconButton(
        onPressed: () {
          recoverpassController.isVisiblePass =
              !recoverpassController.isVisiblePass;
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
          recoverpassController.isVisiblePassRepeat =
              !recoverpassController.isVisiblePassRepeat;
        },
        icon: Icon(
          recoverpassController.isVisiblePassRepeat
              ? Icons.visibility
              : Icons.visibility_off,
        ),
      ),
      textEditingController: recoverpassController.ctrlPasswordToConfirm,
    );

    /* 📌 btn para cambiar la contraseña */
    Widget btnChangePass = BtnPrimaryInk(
      text: recoverpassController.isLoading
          ? "Cambiando..."
          : "Cambiar contraseña",
      loading: recoverpassController.isLoading,
      onTap: () => {},
    );

    return UserLayout(
      true,
      child: SafeArea(
        child: CustomContainer(
          content: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      // TextTittle(
                      //   tittle: 'Restablecer contraseña',
                      //   subTittle: 'Por favor escribe algo que recuerdes',
                      // ),
                      Text(
                        'Restablecer contraseña',
                        style: AppTextStyle(context).bold17(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryConst,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text('Por favor escribe algo que recuerdes'),
                      const SizedBox(height: 20.0),
                      inputPass,
                      const SizedBox(height: 20.0),
                      inputSecondPass,
                      const SizedBox(height: 20.0),
                      CustomValidators(
                        password: recoverpassController.ctrlPassword.text,
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
                btnChangePass,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomValidators extends StatelessWidget {
  final String password;

  const CustomValidators({super.key, required this.password});

  bool get hasMinLength => password.length >= 6;
  bool get hasNumber => password.contains(RegExp(r'[0-9]'));
  bool get hasUppercase => password.contains(RegExp(r'[A-Z]'));

  Widget _buildItem(bool condition, String text) {
    return Row(
      children: [
        Icon(
          condition ? Icons.check_circle : Icons.radio_button_unchecked,
          color: condition ? Colors.green : Colors.grey,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: condition ? Colors.black : Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.0,
      children: [
        _buildItem(hasMinLength, 'Contiene al menos 6 caracteres'),
        _buildItem(hasNumber, 'Contiene al menos un número'),
        _buildItem(hasUppercase, 'Contiene al menos una mayúscula'),
      ],
    );
  }
}
