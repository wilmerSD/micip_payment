import 'package:cip_payment_web/app/ui/components/custom_tab_switch.dart';
import 'package:cip_payment_web/app/ui/components/header.dart';
import 'package:cip_payment_web/app/ui/views/proofnodebt/proofnodebt_provider.dart';
import 'package:cip_payment_web/app/ui/views/proofnodebt/widgets/proofnodebt_history.dart';
import 'package:cip_payment_web/app/ui/views/proofnodebt/widgets/proofnodebt_pay.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProofnodebtViewDesktop extends StatelessWidget {
const ProofnodebtViewDesktop({ super.key });

    @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      spacing: 10.0,
      children: [
        Header(
          options: _options(),
          tittle: textProofnodebt,
        ),
        Expanded(
          child: Padding(
                  padding: const EdgeInsetsGeometry.all(15),
            child: PageView(
              controller: context.read<ProofnodebtProvider>().pageController,
              onPageChanged: (index) =>
                  context.read<ProofnodebtProvider>().onPageChanged(index),
              children: const [
                ProofnodebtPay(),
                ProofnodebtHistory(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget _options() {
  return Consumer<ProofnodebtProvider>(
    builder: (context, provider, _) {
      return CustomTabSwitch(
        tabs: const ['Pagar', 'Historial'],
        selectedIndex: provider.selectedIndex,
        onChanged: (index) => provider.selectTab(index),
      );
    },
  );
}
