import 'package:cip_payment_web/app/ui/components/alert/alert_dialog_component.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

enum AnimationStyles { defaultStyle, custom, none }

enum Menu { profile, closeSesion }

class PopupMenuExample extends StatefulWidget {
  const PopupMenuExample({super.key});

  @override
  State<PopupMenuExample> createState() => _PopupMenuExampleState();
}

class _PopupMenuExampleState extends State<PopupMenuExample> {
  AnimationStyle? _animationStyle;

  @override
  Widget build(BuildContext context) {
    _animationStyle = const AnimationStyle(
      curve: Easing.emphasizedDecelerate,
      duration: Duration(seconds: 1),
    );
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PopupMenuButton<Menu>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: AppColors.shadowAppBarColor(context), // 👈 color del borde
                width: 2, // grosor del borde
              ),
            ),
            elevation: 0,
            offset: const Offset(-20, 60), // 👈 Esto baja el menú 20px
            color: AppColors.backgroundColor(context),
            borderRadius: BorderRadius.circular(16),
            shadowColor: const Color.fromARGB(145, 158, 158, 158).withValues(),
            popUpAnimationStyle: _animationStyle,
            icon: CircleAvatar(
              radius: 20.0,
              backgroundColor: AppColors.drawerColor(context),
              child: Icon(Bootstrap.person_fill, color: Colors.white),
            ),
            onSelected: (Menu item) {
              switch (item) {
                case Menu.profile:
                  context.go(AppRoutesName.PROFILE);
                  break;
                case Menu.closeSesion:
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialogComponent(
                        onTapButton: () => context.go(AppRoutesName.LOGIN),
                        title: "¿Seguro que quieres salir de MiCip?",
                      );
                    },
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              const PopupMenuItem<Menu>(
                value: Menu.profile,
                child: ListTile(
                  leading: Icon(BoxIcons.bx_user),
                  title: Text('Perfil'),
                ),
              ),

              const PopupMenuDivider(),

              PopupMenuItem<Menu>(
                value: Menu.closeSesion,
                child: ListTile(
                  leading: Icon(Iconsax.logout_outline),
                  title: Text('Cerrar sesión'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
