import 'package:cip_payment_web/app/ui/views/home/home_provider.dart';
import 'package:cip_payment_web/app/ui/views/home/widgets/option_type_pay.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeViewDesktop extends StatelessWidget {
  const HomeViewDesktop({super.key, required this.homeProvider});

  final HomeProvider homeProvider;
  @override
  Widget build(BuildContext context) {
    return
    // body: ListView(
    Column(
      children: [
        SizedBox(height: 35.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 40.0,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            OptionTypePay(
              text: textMonthlyfees,
              icon: Bootstrap.calendar2_check,
              context: context,
              colorBackIcon: const Color.fromRGBO(108, 14, 16, .5),
              colorIcon: const Color.fromRGBO(108, 14, 16, 1),
              ontap: () => context.go(AppRoutesName.MONTHLYFEES),
              whatPlatformIs: 2,
            ),
            OptionTypePay(
              text: textCertificateskill,
              icon: Bootstrap.award,
              context: context,
              colorBackIcon: const Color.fromRGBO(215, 181, 109, .5),
              colorIcon: const Color.fromRGBO(215, 181, 109, 1),
              ontap: () => context.go(AppRoutesName.CERTIFICATESKILL),
              whatPlatformIs: 2,
            ),
            OptionTypePay(
              text:  textProofnodebt,
              icon: Bootstrap.file_earmark_text,
              context: context,
              colorBackIcon: const Color.fromRGBO(42, 42, 41, .5),
              colorIcon: const Color.fromRGBO(42, 42, 41, 1),
              ontap: () => context.go(AppRoutesName.PROOFNODEBT),
              whatPlatformIs: 2,
            ),
            OptionTypePay(
              text: textAdvancepayment,
              icon: Bootstrap.cash_stack,
              context: context,
              colorBackIcon: const Color.fromRGBO(227, 30, 36, .5),
              colorIcon: const Color.fromRGBO(227, 30, 36, 1),
              ontap: () => context.go(AppRoutesName.ADVANCEPAYMENT),
              whatPlatformIs: 2,
            ),
          ],
        ),
        SizedBox(height: 40.0),
        // const FooterDesktop(),
        // const Spacer(),
        // const CourseExplore()
      ],
    );
  }
}
