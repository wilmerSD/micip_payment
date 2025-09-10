import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/app/ui/views/layout/layout_provider.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/helpers/responsive.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LayoutProvider>(
      builder: (context, provider, _) {
        return Material(
          elevation: 0.0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kPaddingAppLargeApp,
              vertical: kMarginApp,
            ),
            decoration: BoxDecoration(
              color: AppColors.headerColor(context),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowAppBarColor(context),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(1, 2),
                ),
              ],
            ),
            child: Responsive.isDesktop(context)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _lateralMenu(context, provider),
                      const ProfileCard(),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _lateralMenu(context, provider);
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Icon(
                                Iconsax.menu_1_outline,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15.0),
                          Text(
                            provider.setNavBarTitle(),
                            // style: AppTextStyle(context).bold32(),
                          ),
                        ],
                      ),
                      const ProfileCard(),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget _lateralMenu(BuildContext context, LayoutProvider provider) {
    if (Responsive.isDesktop(context)) {
      Scaffold.of(context).closeDrawer();
      return Text(
        provider.setNavBarTitle(),
        // style: AppTextStyle(context).bold32(),
        textAlign: TextAlign.left,
      );
    } else {
      Scaffold.of(context).openDrawer();
      return const SizedBox();
    }
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LayoutProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final person = authProvider.currentPerson;
    final String fullNamePerson =
        '${person?.namePerson ?? ''} ${person?.paternalSurname ?? ''} ${person?.motherSurname ?? ''}';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: kSizeNormalMediun),
        Responsive.isDesktop(context)
            ? Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        fullNamePerson,
                        style: AppTextStyle(
                          context,
                        ).textHeaderRightMain(),
                      ),
                      const SizedBox(height: kSizeLittle),
                      ValueListenableBuilder<String>(
                        valueListenable: provider.nameRolUser,
                        builder: (_, role, __) => Text(
                          person?.numberCip ?? '',
                          style: AppTextStyle(
                            context,
                          ).textHeaderRightSec(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: kSizeSmallLittle),
                  CircleAvatar(
                    radius: 20.0,
                    backgroundColor: AppColors.drawerColor(context),
                    child: Icon(Bootstrap.person_fill, color: Colors.white),
                  ),
                  
                ],
              )
            : Row(
                children: [
                  const SizedBox(width: kSizeLittle),
                  GestureDetector(
                    onTap: () {
                      provider.handleBlur();
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundColor: AppColors.drawerColor(context),
                        child: Icon(Bootstrap.person_fill, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
