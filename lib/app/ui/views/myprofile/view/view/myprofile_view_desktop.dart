import 'package:cip_payment_web/app/ui/components/alert/alert_dialog_component.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/myprofile_provider.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/widgets/container_options.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/widgets/custom_data_personal.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/widgets/personal_college.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/widgets/personal_contact.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/widgets/personal_data.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/widgets/reset_pass.dart';
import 'package:cip_payment_web/core/helpers/responsive.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/preferences/shared_preferences.dart';
import 'package:cip_payment_web/core/preferences/theme_provider.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class MyprofileViewDesktop extends StatelessWidget {
  const MyprofileViewDesktop({super.key});

   
  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;

    Widget helpWidget = ContainerOptions(
      const Icon(Bootstrap.life_preserver),
      "Ayuda",
      () {},
      Icons.arrow_forward_ios,
    );

    return Row(
      spacing: 30.0,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: colorTheme.onInverseSurface,// const Color.fromRGBO(227, 30, 36, 0.3),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListView(
              children: [
                profilePhoto(context),
                const SizedBox(height: 30),
                personalData(context),
                const SizedBox(height: 20),
                personalContact(context),
                const SizedBox(height: 20),
                personalColegiatura(context),
                const SizedBox(height: 20),
                darkMode(context),
                const SizedBox(height: 20),
                closeSesion(context),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: CustomDataPersonal(
            context.watch<MyprofileProvider>().selectedIndex == 0
                ? PersonalData()
                : context.watch<MyprofileProvider>().selectedIndex == 1
                ? PersonalContact()
                : context.watch<MyprofileProvider>().selectedIndex == 2
                ? PersonalCollege()
                : ResetPass(),
          ),
        ),
      ],
    );
  }
}

Widget profilePhoto(BuildContext context) {
  final myprofileProvider = Provider.of<MyprofileProvider>(context);
  return Column(
    spacing: 5.0,
    children: [
      Center(
        child: Stack(
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: myprofileProvider.profileImage != null
                  ? FileImage(myprofileProvider.profileImage!)
                  : null,
              child: myprofileProvider.profileImage != null
                  ? const SizedBox()
                  : const Icon(Icons.person, size: 80),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  // myprofileProvider.pickImageFromGallery();
                },
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
}

Widget personalData(BuildContext context) {
  final myprofileProvider = Provider.of<MyprofileProvider>(context);
  return ContainerOptions(
    const CircleAvatar(
      backgroundColor: AppColors.red,
      child: Icon(Bootstrap.person, color: Colors.white),
    ),
    'Datos personales',
    () {
      Responsive.isDesktop(context)
          ? myprofileProvider.goToPersonalData(context)
          : context.go(AppRoutesName.PERSONALDATA);
    },
    Icons.arrow_right,
  );
}

Widget personalContact(BuildContext context) {
  final myprofileProvider = Provider.of<MyprofileProvider>(context);
  return ContainerOptions(
    const CircleAvatar(
      backgroundColor: AppColors.red,
      child: Icon(Bootstrap.file_person, color: Colors.white),
    ),
    'Contacto',
    () {
      Responsive.isDesktop(context)
          ? myprofileProvider.goToPersonalContact(context)
          : context.go(AppRoutesName.PERSONALCONTACT);
    },
    Icons.arrow_right,
  );
}

Widget personalColegiatura(BuildContext context) {
  final myprofileProvider = Provider.of<MyprofileProvider>(context);
  return ContainerOptions(
    const CircleAvatar(
      backgroundColor: AppColors.red,
      child: Icon(Bootstrap.award, color: Colors.white),
    ),
    'Colegiatura',
    () {
      Responsive.isDesktop(context)
          ? myprofileProvider.goToPersonalCollege(context)
          : context.go(AppRoutesName.PERSONALCOLLEGE);
    },
    Icons.arrow_right,
  );
}

Widget darkMode(BuildContext context) {
  final prefs = PreferencesUser();
  return ContainerOptions(
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
      Provider.of<ThemeProvider>(context, listen: false).getValueTheme = !value;
    },
    prefs.themeBool ? Icons.dark_mode_outlined : Icons.light_mode,
  );
}

Widget closeSesion(BuildContext context) {
  return ContainerOptions(const Icon(Bootstrap.door_open), "Cerrar Sesión", () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogComponent(
          onTapButton: () => context.go(AppRoutesName.LOGIN),
          title: "¿Seguro que quieres salir de MiCip?",
        );
      },
    );
  }, Icons.arrow_forward_ios);
}
