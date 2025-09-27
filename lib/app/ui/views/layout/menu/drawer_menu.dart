import 'package:cip_payment_web/infrastructure/models/response_menu_model.dart';
import 'package:cip_payment_web/app/ui/components/alert/alert_dialog_component.dart';
import 'package:cip_payment_web/app/ui/views/layout/layout_provider.dart';
import 'package:cip_payment_web/app/ui/views/layout/menu/menu_option.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    super.key,
    this.isCollapsed = false,
    this.onTapCollapsed,
    required this.onTapMenu,
  });

  final bool isCollapsed;
  final Function()? onTapCollapsed;
  final Function(String idMenu) onTapMenu;
  @override
  Widget build(BuildContext context) {
    final layoutProvider = context
        .watch<LayoutProvider>(); // Obtiene el provider actual
    final colorTheme = Theme.of(context).colorScheme;
    // Color colorDrawer = colorTheme.inversePrimary;
     Color colorDrawer = AppColors.drawerColor(context);
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      // elevation: 2.0,
      backgroundColor: colorDrawer,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: colorDrawer,
            child: GestureDetector(
              onTap: onTapCollapsed,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(255, 241, 238, 239),
                    ),
                  ),
                ),
                child: isCollapsed
                    ? Icon(
                        Iconsax.menu_1_outline,
                        color: Colors.white,
                        size: 20,
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 60.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 8.0,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/LOGO_CIP.png',
                                          ), // Reemplaza con tu imagen
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'MiCIP',
                                      style: AppTextStyle(context).bold30(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: layoutProvider.options.length + 1,
              itemBuilder: (_, index) {
                if (index == layoutProvider.options.length) {
                  return const Stack(children: [
                    
                    ],
                  );
                } else {
                  return MenuOption(
                    item: layoutProvider.options[index],
                    isCollapsed: isCollapsed,
                    onTapMenu: () {
                      if (layoutProvider.options[index].isDesplegable!) {
                        if (isCollapsed) {
                          onTapCollapsed!();
                        }
                        layoutProvider.setDesplegated(
                          layoutProvider.options[index].route ?? "",
                        );
                      } else {
                        layoutProvider.setActive(
                          layoutProvider.options[index].route ?? "",
                        );
                      }
                    },
                    onTapSubMenu: (route) {},
                  );
                }
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MenuOption(
              onTapSubMenu: (route) {},
              item: ResponseMenuOptionsModel(
                isChild: false,
                isDesplegated: false,
                route: "/login",
                nameOption: "Cerrar Sesión",
                isDesplegable: false,
                isActive: false,
                onTap: () {},
                iconOption: iconsHeader(
                  Iconsax.logout_outline,
                ),
              ),
              isCollapsed: isCollapsed,
              onTapMenu: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialogComponent(
                      onTapButton: () => context.go(AppRoutesName.LOGIN),
                      title: "¿Seguro que quieres salir de MiCip?",
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget iconsHeader(IconData icon) {
  return Icon(icon, color: Colors.white, size: 20);
}
