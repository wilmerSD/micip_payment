import 'dart:io';
import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/app/ui/components/alert/alert_dialog_component.dart';
import 'package:cip_payment_web/app/ui/components/alert/cupertino_alert_dialog_comp.dart';
import 'package:cip_payment_web/app/ui/components/userlayout/user_layout.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/myprofile_provider.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:cip_payment_web/preferences/shared_preferences.dart';
import 'package:cip_payment_web/preferences/theme_provider.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MyprofileView extends StatelessWidget {
  const MyprofileView({super.key});

  @override
  Widget build(BuildContext context) {
    final myprofileController = Provider.of<MyprofileProvider>(
      context,
      listen: false,
    );
    final authProvider = Provider.of<AuthProvider>(context);
    final person = authProvider.currentPerson;
    bool whatPlatformIs = false;
    if (!kIsWeb) {
      whatPlatformIs = Platform.isIOS;
      // lógica específica para plataformas móviles o desktop
    } else {
      // lógica alternativa para web
    }

    final prefs = PreferencesUser();

    Widget profilePhoto = Column(
      spacing: 5.0,
      children: [
        Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: myprofileController.profileImage != null
                    ? FileImage(myprofileController.profileImage!)
                    : null,
                child: myprofileController.profileImage != null
                    ? const SizedBox()
                    : const Icon(Icons.person, size: 80),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () => myprofileController.pickImageFromGallery(),
                  child: const Icon(Iconsax.edit_outline),
                ),
              ) /* CircleAvatar(
                          backgroundColor: AppColors.blueCustom,
                          child: Icon(Iconsax.edit_outline, color: Colors.white,))) */,
            ],
          ),
        ),
        // Center(
        //     child: loginController.responsedata.personalNombres != null
        //         ? Text(
        //             '${loginController.responsedata.personalNombres} ${loginController.responsedata.personalApellidos}',
        //             style: AppTextStyle(context)
        //                 .bold16(color: AppColors.textBasic(context)))
        //         : Text(splashController.names + splashController.lastName))
      ],
    );

    Widget darkMode = _customContainer(
      context,
      SizedBox(
        width: 25,
        child: Transform.scale(
          scale: 0.5,
          child: Switch(
            value: prefs.themeBool,
            onChanged: (_) {
              bool value = prefs.themeBool;
              prefs.themeBool = !value;
              Provider.of<ThemeProvider>(context, listen: false).getValueTheme =
                  !value;
            },
          ),
        ),
      ),
      'Modo oscuro',
      () {
        bool value = prefs.themeBool;
        prefs.themeBool = !value;
        Provider.of<ThemeProvider>(context, listen: false).getValueTheme =
            !value;
      },
      prefs.themeBool ? Icons.dark_mode_outlined : Icons.light_mode,
    );
    Widget personalData = _customContainer(
      context,
      const CircleAvatar(
        backgroundColor: AppColors.red,
        child: Icon(Bootstrap.person, color: Colors.white),
      ),
      'Datos personales',
      () {
        myprofileController.goToPersonalData(context);
      },
      Icons.arrow_right,
    );
    Widget personalContact = _customContainer(
      context,
      const CircleAvatar(
        backgroundColor: AppColors.red,
        child: Icon(Bootstrap.file_person, color: Colors.white),
      ),
      'Contacto',
      () {
        myprofileController.goToPersonalContact(context);
      },
      Icons.arrow_right,
    );

    Widget personalColegiatura = _customContainer(
      context,
      const CircleAvatar(
        backgroundColor: AppColors.red,
        child: Icon(Bootstrap.award, color: Colors.white),
      ),
      'Colegiatura',
      () {
        myprofileController.goToPersonalCollege(context);
      },
      Icons.arrow_right,
    );
    Widget changePassword = _customContainer(
      context,
      const CircleAvatar(
        backgroundColor: AppColors.red,
        child: Icon(Bootstrap.lock, color: Colors.white),
      ),
      'Cambiar contraseña',
      () {
        context.go(AppRoutesName.RESETPASS);
      },
      Icons.arrow_right,
    );
    Widget closeSesion = _customContainer(
      context,
      const Icon(Bootstrap.door_open),
      "Cerrar Sesión",
      () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return whatPlatformIs
                ? CupertinoAlertDialogComp(
                    tittle: '¿Seguro que quieres salir de MiCip?',
                    onTapButton: () => context.go(AppRoutesName.LOGIN),
                  )
                : AlertDialogComponent(
                    onTapButton: () => context.go(AppRoutesName.LOGIN),
                    title: "¿Seguro que quieres salir de MiCip?",
                  );
          },
        );
      },
      Icons.arrow_forward_ios,
    );

    Widget helpWidget = _customContainer(
      context,
      const Icon(Bootstrap.life_preserver),
      "Ayuda",
      () {},
      Icons.arrow_forward_ios,
    );

    return UserLayout(
      person?.isAdmin ?? false ? false : true,
      // true,
      child: ListView(
        children: [
          personalData,
          const SizedBox(height: 20),
          personalContact,
          const SizedBox(height: 20),
          personalColegiatura,
          // const SizedBox(height: 20),
          // changePassword,
          const SizedBox(height: 20),
          darkMode,
          const SizedBox(height: 20),
          closeSesion,
        ],
      ),
    );
  }
}

Widget _customContainer(
  BuildContext context,
  Widget icon,
  String text,
  VoidCallback ontap,
  IconData iconRight,
) {
  return InkWell(
    onTap: ontap,
    borderRadius: BorderRadius.circular(10.0),
    child: Container(
      height: 70.0,
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0 /*  vertical: 20.0 */,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color.fromARGB(92, 249, 249, 250),
        border: Border.all(color: const Color.fromRGBO(232, 242, 250, 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 10.0,
            children: [
              icon,
              Text(
                text,
                style: AppTextStyle(context).bold16(
                  // fontWeight: FontWeight.w500,
                  color: AppColors.textBasic(context),
                ),
              ),
            ],
          ),
          Icon(iconRight),
        ],
      ),
    ),
  );
}
