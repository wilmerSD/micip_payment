import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/app/ui/components/userlayout/user_layout.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/view/view/myprofile_view_desktop.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/view/view/myprofile_view_mobile.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/view/view/myprofile_view_tablet.dart';
import 'package:cip_payment_web/core/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyprofileView extends StatelessWidget {
  const MyprofileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final person = authProvider.currentPerson;

    return UserLayout(
      !(person?.isAdmin ?? false),
      // true,
      child: Responsive.isDesktop(context)
      ? MyprofileViewDesktop()
      : Responsive.isTablet(context)
          ? MyprofileViewTablet()
          : MyprofileViewMobile(),
    );
  }
}
