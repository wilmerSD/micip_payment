import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/components/field_form.dart';
import 'package:cip_payment_web/app/ui/views/login/login_provider.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RecoverpassView extends StatelessWidget {
  const RecoverpassView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ya que se está utilizando Provider, no necesitas definirlo de nuevo aquí.
    final loginController = Provider.of<LoginProvider>(context);
    Widget imageLogo = Container(
      width: 100.0,
      height: 100.0,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/LOGO_CIP.png'), // Reemplaza con tu imagen
          fit: BoxFit.cover,
        ),
      ),
    );
    Widget identificationNumber = FieldForm(
      label: "DNI",
      hintText: "Ingresa tu usuario",
      textInputType: TextInputType.emailAddress,
      textEditingController: loginController.ctrlDni,
    );

    Widget nameUser = FieldForm(
      label: "Colegiado",
      hintText: "Ingresa tu usuario",
      textInputType: TextInputType.emailAddress,
      textEditingController: loginController.ctrlName,
    );

    Widget emailUser = FieldForm(
      label: "Correo",
      hintText: "Ingresa tu usuario",
      textInputType: TextInputType.emailAddress,
      textEditingController: loginController.ctrlUserName,
    );

    Widget button = BtnPrimaryInk(
      text: "Enviar contraseña",
      onTap: () {
        
      },
      /*onTap: () =>  controller.validateForm(context) */
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            padding: EdgeInsets.all(10.0),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: CircleAvatar(child: Icon(Icons.arrow_back))),
      ),
      
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              // padding: const EdgeInsets.all(15.0),
              width: 400.0,
              // height: 630.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 25.0,
                children: [
                  // Stack(
                  //   children: [
                  //     // Align(
                  //     //   alignment: Alignment.topRight,
                  //     //   child: Lottie.asset(
                  //     //     'assets/recoverPassAnimation.json',
                  //     //     width: 200,
                  //     //     height: 200,
                  //     //     fit: BoxFit.contain,
                  //     //     repeat: false,
                  //     //   ),
                  //     // ),
                  //     Container(
                  //       height: 190,
                  //       // color: Colors.red,
                  //       child: Align(
                  //         alignment: Alignment.bottomLeft,
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: [
                  //             Text("¿Olvidaste tu contraseña?",
                  //                 style: AppTextStyle(context).bold22()),
                  //             Text(
                  //                 "No te preocupes, eso pasa. Por favor, ingrese su email asociado con su cuenta",
                  //                 style: TextStyle(
                  //                   fontSize: 14.0,
                  //                   fontWeight: FontWeight.w500,
                  //                   color: AppColors.black,
                  //                 )),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 25.0),
                  Text("¿Olvidaste tu contraseña?",
                      style: AppTextStyle(context).bold22()),
                  Text(
                      "No te preocupes, eso pasa. Por favor, ingrese su email asociado con su cuenta",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      )),
                  // dni
                  identificationNumber,
                  //correo
                  // emailUser,
                  //Boton
                  button,
                  const Spacer(),
                  Center(
                    child: InkWell(
                      onTap: () => context.go(AppRoutesName.LOGIN),
                      child: Text('Regresar a  inicio de sesión',
                          style: AppTextStyle(context)
                              .bold14(color: AppColors.primaryConst)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
