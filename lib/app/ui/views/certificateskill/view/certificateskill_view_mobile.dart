import 'package:cip_payment_web/app/ui/components/custom_tab_switch.dart';
import 'package:cip_payment_web/app/ui/views/certificateskill/widgets/certificateskill_history.dart';
import 'package:cip_payment_web/app/ui/views/certificateskill/widgets/certificateskill_pay.dart';
import 'package:flutter/material.dart';
import 'package:cip_payment_web/app/ui/views/certificateskill/certificateskill_provider.dart';
import 'package:provider/provider.dart';

class CertificateskillViewMobile extends StatelessWidget {
  const CertificateskillViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.0,
      children: [
        Container(
            // height: 20.0,
            child: optionsCertificateSkill()),
        Expanded(
          child: Padding(
                  padding:const EdgeInsetsGeometry.all(15),
            child: PageView(
              controller: context.read<CertificateSkillProvider>().pageController,
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

Widget optionsCertificateSkill() {
  return Consumer<CertificateSkillProvider>(
    builder: (context, provider, _) {
      return CustomTabSwitch(
        tabs: const ['Pagar', 'Historial'],
        selectedIndex: provider.selectedIndex,
        onChanged: (index) => provider.selectTab(index),
      );
    },
  );
}
