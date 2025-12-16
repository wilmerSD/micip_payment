import 'package:cip_payment_web/app/ui/components/custom_tab_switch.dart';
import 'package:cip_payment_web/app/ui/views/certificateskill/certificateskill_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionsCertificateskill extends StatelessWidget {
const OptionsCertificateskill({ super.key });

  @override
  Widget build(BuildContext context){
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
}