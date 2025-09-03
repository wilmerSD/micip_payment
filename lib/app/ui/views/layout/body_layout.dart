import 'package:animate_do/animate_do.dart';
import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/app/ui/views/layout/layout_provider.dart';
import 'package:cip_payment_web/app/ui/views/layout/nav_bar.dart';
import 'package:cip_payment_web/app/ui/views/layout/routeDataTemporary.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/helpers/responsive.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;
import 'package:provider/provider.dart';

class BodyLayout extends StatelessWidget {
  const BodyLayout({super.key, this.marginLayout});
  final EdgeInsetsGeometry? marginLayout;
  @override
  Widget build(BuildContext context) {
    return Consumer<LayoutProvider>(
      builder: (context, provider, _) {
        return Stack(
          children: [
            Column(
              children: [
                const NavBar(),
                Expanded(
                  child: Container(
                    color: AppColors.backgroundColor(context),
                    margin:
                        marginLayout ??
                        const EdgeInsets.only(
                          top: kMarginMediunApp,
                          left: kMarginLargeApp,
                          right: kMarginLargeApp,
                        ),
                    child: Builder(
                      builder: (context) {
                        web.window.history.pushState(
                          null,
                          '',
                          RouteDataTemporary.currentRoute,
                        );
                        return provider.setScreen();
                      },
                    ),
                  ),
                ),
              ],
            ),
            Responsive.isMobile(context) || Responsive.isTablet(context)
                ? Visibility(
                    visible: provider.isShowDownAvatar,
                    child: customPopUpHeader(context),
                  )
                : Visibility(
                    visible: provider.isShowDownAvatar,
                    child: customPopUpHeader(context),
                  ),
          ],
        );
      },
    );
  }
}

Widget customPopUpHeader(BuildContext context) {
  final authProvider = Provider.of<AuthProvider>(context);
  final person = authProvider.currentPerson;

  final String fullNamePerson =
      '${person?.namePerson ?? ''} ${person?.paternalSurname ?? ''} ${person?.motherSurname ?? ''}';
  final String cipPerson = person?.numberCip ?? '';
  return Positioned(
    top: 75,
    right: 20,
    child: FlipInY(
      animate: true,
      duration: const Duration(milliseconds: 100),
      child: Container(
        padding: const EdgeInsets.only(
          top: kPaddingAppNormalApp,
          bottom: kPaddingAppNormalApp,
          left: kPaddingAppNormalApp,
          right: 25,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadiusSmall),
          color: AppColors.backgroundColor(context),
          boxShadow: [
             
            BoxShadow(
              color: const Color.fromARGB(103, 158, 158, 158).withValues(),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(
                0,
                3,
              ), // Cambia la posición de la sombra según tus necesidades
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  fullNamePerson,
                  textScaler: TextScaler.linear(1),
                  style: AppTextStyle(
                    context,
                  ).textHeaderRightMain(),
                ),
                const SizedBox(width: kSizeLittle),
                Text(
                  cipPerson,
                  textScaler: TextScaler.linear(1),
                  style: AppTextStyle(
                    context,
                  ).textHeaderRightSec(),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
