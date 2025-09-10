import 'package:cip_payment_web/app/ui/views/myprofile/view/view/myprofile_view_desktop.dart';
import 'package:flutter/material.dart';

class MyprofileViewMobile extends StatelessWidget {
const MyprofileViewMobile({ super.key });

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
    
    ],
  );
}
}