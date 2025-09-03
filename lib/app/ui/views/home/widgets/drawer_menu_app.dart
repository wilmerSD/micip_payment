import 'dart:io';
import 'package:cip_payment_web/app/ui/components/alert/alert_dialog_component.dart';
import 'package:cip_payment_web/app/ui/components/alert/cupertino_alert_dialog_comp.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class DrawerMenuApp extends StatelessWidget {
  const DrawerMenuApp({super.key});

  @override
  Widget build(BuildContext context) {

    bool isIos = false;
    if (!kIsWeb) {
      isIos = Platform.isIOS;
    }
    return Drawer(
      backgroundColor: AppColors.backgroundColor(context),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primaryConst,
              radius: kRadiusLarge,
              child: Icon(Icons.person,
                  color: AppColors.backgroundColor(context), size: 30.0),
            ),
            const SizedBox(height: kSize),
            Text(
              "Hola,",
              style: AppTextStyle(context).medium14(
                color: AppColors.quaternaryConst,
              ),
            ),
            Text(
              "José Wilmer Sanchez Díaz",
              style: AppTextStyle(context).bold18(
                color: AppColors.quaternaryConst,
              ),
            ),
            const SizedBox(height: kSize),
            customDivider(),
            customListTile(context, "Perfil", BoxIcons.bx_user, () {
              context.push(AppRoutesName.PROFILE);
            }),
            customDivider(),
            customListTile(context, "IEPI", BoxIcons.bx_book, () {
              context.push(AppRoutesName.IEPI);
            }),
            customDivider(),
            customListTile(context, "Capítulo", Icons.book_online, () {}),
            customDivider(),
            customListTile(
                context, "Gestión", Icons.admin_panel_settings, () {}),
            customDivider(),
            customListTile(
                context, "Persona", Icons.person, () {
                context.push(AppRoutesName.PERSON);
                }),
            const Spacer(),
            customListTile(context, "Cerrar sesión", Icons.logout, () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return isIos
                      ? CupertinoAlertDialogComp(
                          tittle: '¿Estás seguro(a) de cerrar sesión?',
                          onTapButton: () => context.go(AppRoutesName.LOGIN))
                      : AlertDialogComponent(
                          onTapButton: () => {context.go(AppRoutesName.LOGIN)},
                          title: "¿Estás seguro(a) de cerrar sesión?");
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

Widget customListTile(
    BuildContext context, String text, IconData icon, Function() ontap) {
  return ListTile(
    onTap: ontap,
    contentPadding: const EdgeInsets.symmetric(horizontal: kPaddingAppLargeApp),
    leading: Icon(
      icon,
      size: kIconSizeSmall,
      color: AppColors.quaternaryConst,
    ),
    title: Text(
      text,
      style: AppTextStyle(context).medium14(
        color: AppColors.quaternaryConst,
      ),
    ),
  );
}

Widget customDivider() {
  return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Divider(color: AppColors.grayLight));
}
