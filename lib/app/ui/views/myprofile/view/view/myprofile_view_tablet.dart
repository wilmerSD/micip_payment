import 'package:cip_payment_web/app/ui/views/myprofile/myprofile_provider.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/view/view/myprofile_view_desktop.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/widgets/custom_data_personal.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/widgets/personal_college.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/widgets/personal_contact.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/widgets/personal_data.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/widgets/reset_pass.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyprofileViewTablet extends StatelessWidget {
  const MyprofileViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;

    return Row(
      spacing: 30.0,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: colorTheme.onInverseSurface,
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
