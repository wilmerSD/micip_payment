import 'package:cip_payment_web/app/models/response_menu_model.dart';
import 'package:cip_payment_web/app/ui/views/layout/layout_provider.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class MenuOption extends StatelessWidget {
  const MenuOption({
    super.key,
    required this.item,
    required this.isCollapsed,
    required this.onTapMenu,
    required this.onTapSubMenu,
  });
  final ResponseMenuOptionsModel item;
  final bool isCollapsed;
  final void Function() onTapMenu;
  final void Function(String route) onTapSubMenu;

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    // Color colorDrawer = colorTheme.onInverseSurface;
    Color colorDrawer = AppColors.drawerColor(context);
    final layoutProvider =
        context.watch<LayoutProvider>(); // Obtiene el provider actual

    return Column(
      children: [
        Material(
          color: colorDrawer,
          child: InkWell(
            onTap: item.isChild!
                ? () {
                    layoutProvider.setActive(item.route!);
                  }
                : onTapMenu,
            child: Container(
              color: item.isChild!
                  ? colorDrawer
                  : colorDrawer,
              padding: const EdgeInsets.only(
                  top: 12.0, bottom: 12.0, left: 15.0, right: 0.0),
              child: isCollapsed
                  ? Row(children: [
                      Center(
                        child: item.iconOption,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      item.isDesplegable!
                          ? const SizedBox()
                          : item.isActive!
                              ? Container(
                                  height: 23.0,
                                  width: 6.0,
                                  decoration: BoxDecoration(
                                      color: AppColors.secondConst,
                                      borderRadius: BorderRadius.circular(3.0)),
                                )
                              : const SizedBox(
                                  width: 6.0,
                                )
                    ])
                  : Row(children: [
                      SizedBox(
                        child: item.iconOption,
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                          child: Text(
                        item.nameOption ?? "",
                        style: AppTextStyle(context).regular14(
                          color: item.isChild!
                              ? Colors.white
                              : Colors.white,
                        ),
                      )),
                      item.isDesplegable!
                          ? GestureDetector(
                              onTap: item.isChild!
                                  ? () {
                                      layoutProvider.setActive(item.route!);
                                    }
                                  : onTapMenu,
                              child: Container(
                                  margin: const EdgeInsets.only(right: 10.0),
                                  child: Icon(item.isDesplegated ?? false
                                      ? Iconsax.arrow_up_1_bold
                                      : Iconsax.arrow_down_bold, size: 20.0,color: Colors.white,))
                              )
                          : item.isActive!
                              ? Container(
                                  height: 23.0,
                                  width: 6.0,
                                  margin: const EdgeInsets.only(right: 10.0),
                                  decoration: BoxDecoration(
                                      color: AppColors.secondConst,
                                      borderRadius: BorderRadius.circular(3.0)),
                                )
                              : const SizedBox()
                    ]),
            ),
          ),
        ),
        item.isDesplegated ?? false
            ? SizedBox(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: item.child!.length,
                    itemBuilder: (context, index) => MenuOption(
                          item: item.child![index],
                          isCollapsed: isCollapsed,
                          onTapMenu: onTapMenu,
                          onTapSubMenu: (route) {},
                        )),
              )
            : const SizedBox()
      ],
    );
  }
}
