import 'package:cip_payment_web/app/ui/components/userlayout/user_layout.dart';
import 'package:cip_payment_web/app/ui/views/certificateskill/view/certificateskill_tablet.dart';
import 'package:cip_payment_web/app/ui/views/certificateskill/view/certificateskill_view_desktop.dart';
import 'package:cip_payment_web/app/ui/views/certificateskill/view/certificateskill_view_mobile.dart';
import 'package:cip_payment_web/core/helpers/responsive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CertificateSkillView extends StatelessWidget {
  const CertificateSkillView({super.key});

  @override
  Widget build(BuildContext context) {

    return UserLayout(
      true,
      child: kIsWeb
              ? (Responsive.isDesktop(context)
                  ? CertificateSkillViewDesktop()
                  : (Responsive.isTablet(context)
                      ? CertificateSkillViewTablet()
                      : CertificateSkillViewMobile()))
              : CertificateSkillViewMobile(),
    );
  }
}
