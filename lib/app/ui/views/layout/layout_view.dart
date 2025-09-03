import 'package:cip_payment_web/app/ui/views/layout/body_layout.dart';
import 'package:cip_payment_web/app/ui/views/layout/layout_provider.dart';
import 'package:cip_payment_web/app/ui/views/layout/menu/drawer_menu.dart';
import 'package:cip_payment_web/core/helpers/responsive.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LayoutProvider(),
        child: Builder(builder: (context) {
          final layoutProvider =
              Provider.of<LayoutProvider>(context, listen: false);

          
          // Se ejecuta solo una vez cuando se construye el widget
          WidgetsBinding.instance.addPostFrameCallback((_) {
            layoutProvider.initialize(context);
          });

          return Consumer<LayoutProvider>(builder: (context, provider, _) {
            return Listener(
              onPointerHover: (event) {
                provider.startTimer();
              },
              child: GestureDetector(
                onTap: () {
                  provider.isShowDownAvatar = false;
                },
                child: Scaffold(
                  /* key: GlobalKey(), */
                  backgroundColor: AppColors.backgroundColor(context),
                  drawer: DrawerMenu(
                    onTapMenu: (idMenu) {},
                  ),
                  body: SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Muestra menu lateral solo si es web
                        if (Responsive.isDesktop(context))
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 0),
                            width: provider.isCollapsed ? 52.0 : 280.0,
                            child: DrawerMenu(
                              isCollapsed: provider.isCollapsed,
                              onTapCollapsed: () {
                                provider.collapseAll();
                                provider.isCollapsed = !provider.isCollapsed;
                              },
                              onTapMenu: (idMenu) {},
                            ),
                          ),

                        //Contenido
                        const Expanded(
                          flex: 12,
                          child: SafeArea(
                            top: false,
                            bottom: false,
                            child: BodyLayout(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        }));
  }
}
