import 'package:cip_payment_web/app/ui/components/header.dart';
import 'package:cip_payment_web/app/ui/views/certificateskill/certificateskill_provider.dart';
import 'package:cip_payment_web/app/ui/views/certificateskill/widgets/certificateskill_history.dart';
import 'package:cip_payment_web/app/ui/views/certificateskill/widgets/certificateskill_pay.dart';
import 'package:cip_payment_web/app/ui/views/certificateskill/widgets/options_certificateskill.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CertificateSkillViewDesktop extends StatelessWidget {
  const CertificateSkillViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.0,
      children: [
        Header(
          options: OptionsCertificateskill(),
          tittle: textCertificateskill,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsGeometry.all(15),
            child: PageView(
              controller: context
                  .read<CertificateSkillProvider>()
                  .pageController,
              onPageChanged: (index) =>
                  context.read<CertificateSkillProvider>().onPageChanged(index),
              children: const [
                CertificateskillPay(),
                CertificateskillHistory(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
