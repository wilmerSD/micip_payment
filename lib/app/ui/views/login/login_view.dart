import 'package:cip_payment_web/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/components/field_form.dart';
import 'package:cip_payment_web/app/ui/components/terms_and_conditions.dart';
import 'package:cip_payment_web/app/ui/views/login/login_provider.dart';
import 'package:cip_payment_web/app/ui/views/login/logo.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/widgets/custom_container.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ya que se está utilizando Provider, no necesitas definirlo de nuevo aquí.
    final loginController = Provider.of<LoginProvider>(context);

    Widget password = FieldForm(
      label: "Contraseña",
      hintText: "Ingresa tu contraseña",
      privateText: loginController.isVisibleIcon,
      suffix: GestureDetector(
        onTap: () {
          loginController.isVisibleIcon = !loginController.isVisibleIcon;
          //logincontroller.toggleVisibility(); // Método para cambiar la visibilidad
        },
        child: IconButton(
          onPressed:()=> loginController.isVisibleIcon = !loginController.isVisibleIcon,
          icon: Icon(
            loginController.isVisibleIcon
                ? Icons.visibility
                : Icons.visibility_off,
          ),
        ),
      ),
      textEditingController: loginController.ctrlPassword,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

    Widget user = FieldForm(
      label: "Usuario",
      hintText: "Ingresa tu usuario",
      textInputType: TextInputType.emailAddress,
      textEditingController: loginController.ctrlUserName,
    );
    Widget button = BtnPrimaryInk(
      loading: loginController.isAuthenticating,
      text: loginController.isAuthenticating ? 'Ingresando' : 'Ingresar',
      onTap: () {
        // loginController. getLogin(context);
        loginController.authentication(context);
      },
      /*onTap: () =>  controller.validateForm(context) */
    );

    Widget forgotPassword = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '¿Olvidaste tu contraseña?',
          style: AppTextStyle(context).bold13(
            color: AppColors.quaternaryConst,
            fontWeight: FontWeight.w500,
          ),
        ),
        InkWell(
          onTap: () {
            context.go(AppRoutesName.RECOVERPASS);
          },
          child: Text(
            ' Recuperar aquí',
            style: AppTextStyle(context).bold13(color: AppColors.primaryConst),
          ),
        ),
      ],
    );

    //¿Preguntar por los terminos y condiciones vienen de algun servicio o se pone directo en el codigo ?
    Widget termsAndCoditions = InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) {
          return PopupGeneral(
            scrollable: true,
            onTapButton: () => {},
            title: "",
            content: TermsAndConditions(),
          );
        },
      ),

      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Al continuar, aceptas nuestros ',
              style: AppTextStyle(
                context,
              ).bold10(color: AppColors.quaternaryConst),
            ),
            TextSpan(
              text: 'Términos y Condiciones',
              style: AppTextStyle(
                context,
              ).bold10(color: AppColors.granateConst),
            ),
          ],
        ),
      ),
    );

    Widget rememberPass = InkWell(
      onTap: () => loginController.rememberPass = !loginController.rememberPass,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            side: const BorderSide(color: AppColors.quaternaryConst),
            activeColor: AppColors.primaryConst,
            value: loginController.rememberPass,
            onChanged: (_) {
              loginController.rememberPass = !loginController.rememberPass;
            },
          ),
          Text(
            "Recordar datos",
            style: AppTextStyle(context).bold14(
              color: AppColors.quaternaryConst,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor(context),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Center(
                  child: CustomContainer(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 30.0,
                      children: [
                        const Center(child: Logo()),
                        // const SizedBox(height: 30.0),
                        user,
                        // const SizedBox(height: 30.0),
                        password,
                        // const SizedBox(height: 15.0),
                        rememberPass,
                        // const SizedBox(height: 15.0),
                        Spacer(),
                        button,
                        const SizedBox(height: 10.0),
                        // Center(child: forgotPassword),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                termsAndCoditions,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
