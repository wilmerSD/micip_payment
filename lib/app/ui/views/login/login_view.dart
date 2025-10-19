import 'package:cip_payment_web/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/components/fields/field_form.dart';
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
                        user(context),
                        // const SizedBox(height: 30.0),
                        password(context),
                        // const SizedBox(height: 15.0),
                        rememberPass(context),
                        // const SizedBox(height: 15.0),
                        // Spacer(),
                        button(context),
                        const SizedBox(height: 10.0),
                        Center(child: forgotPassword(context)),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                termsAndCoditions(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget password(BuildContext context) {
  final loginProvider = Provider.of<LoginProvider>(context);
  return FieldForm(
    label: "Password",//,
    hintText: "Ingresa tu contraseña",
    privateText: loginProvider.isVisibleIcon,
    suffix: GestureDetector(
      onTap: () {
        loginProvider.isVisibleIcon = !loginProvider.isVisibleIcon;
        //loginProvider.toggleVisibility(); // Método para cambiar la visibilidad
      },
      child: IconButton(
        onPressed: () =>
            loginProvider.isVisibleIcon = !loginProvider.isVisibleIcon,
        icon: Icon(
          loginProvider.isVisibleIcon
              ? Icons.visibility
              : Icons.visibility_off,
        ),
      ),
    ),
    textEditingController: loginProvider.ctrlPassword,
    onEditingComplete: () {
      FocusScope.of(context).unfocus();
      // Lógica para validar el formulario
    },
  );
}

Widget user(BuildContext context){
final loginProvider = Provider.of<LoginProvider>(context);
return FieldForm(
  label: "Usuario",
  hintText: "Ingresa tu usuario",
  textInputType: TextInputType.emailAddress,
  textEditingController: loginProvider.ctrlUserName,
);
}

Widget button(BuildContext context){
final loginProvider = Provider.of<LoginProvider>(context);
return BtnPrimaryInk(
  loading: loginProvider.isAuthenticating,
  text: loginProvider.isAuthenticating ? 'Ingresando' : 'Ingresar',
  onTap: () {
    // loginProvider. getLogin(context);
    loginProvider.authentication(context);
  },
  /*onTap: () =>  controller.validateForm(context) */
);
}

Widget forgotPassword(BuildContext context){

 return Row(
  mainAxisAlignment: MainAxisAlignment.center,
  mainAxisSize: MainAxisSize.min,
  children: [
    Text(
      '¿Olvidaste tu contraseña?',
      style: AppTextStyle(
        context,
      ).bold13(color: AppColors.quaternaryConst, fontWeight: FontWeight.w500),
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
}

//¿Preguntar por los terminos y condiciones vienen de algun servicio o se pone directo en el codigo ?
Widget termsAndCoditions(BuildContext context){

return InkWell(
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
          style: AppTextStyle(context).bold10(color: AppColors.quaternaryConst),
        ),
        TextSpan(
          text: 'Términos y Condiciones',
          style: AppTextStyle(context).bold10(color: AppColors.granateConst),
        ),
      ],
    ),
  ),
);
}

Widget rememberPass(BuildContext context) {
  final loginProvider = Provider.of<LoginProvider>(context);
  return InkWell(
  onTap: () => loginProvider.rememberPass = !loginProvider.rememberPass,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Checkbox(
        side: const BorderSide(color: AppColors.quaternaryConst),
        activeColor: AppColors.primaryConst,
        value: loginProvider.rememberPass,
        onChanged: (_) {
          loginProvider.rememberPass = !loginProvider.rememberPass;
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
}