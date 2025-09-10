import 'package:cip_payment_web/app/ui/components/userlayout/user_layout.dart';
import 'package:cip_payment_web/app/ui/views/home/view/%20home_view_mobile.dart';
import 'package:cip_payment_web/app/ui/views/home/home_provider.dart';
import 'package:cip_payment_web/app/ui/views/home/view/home_view_desktop.dart';
import 'package:cip_payment_web/app/ui/views/home/view/home_view_tablet.dart';
import 'package:cip_payment_web/core/helpers/responsive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return UserLayout(
      true,
      withFooter: true,
      child: Center(
      child: ChangeNotifierProvider(
          create: (_) => HomeProvider(),
          child: kIsWeb
              ? (Responsive.isDesktop(context)
                  ? HomeViewDesktop(homeProvider: homeProvider)
                  : (Responsive.isTablet(context)
                      ? HomeViewTablet(homeProvider: homeProvider)
                      : HomeViewMobile(homeProvider: homeProvider)))
              : HomeViewMobile(homeProvider: homeProvider),
      ),
    ));
  }
}