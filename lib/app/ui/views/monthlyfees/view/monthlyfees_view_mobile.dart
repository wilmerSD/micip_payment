import 'package:cip_payment_web/app/ui/components/custom_tab_switch.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/monthlyfees_provider.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/widgets/monthlyfees_history.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/widgets/monthlyfees_pay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyfeesMobile extends StatelessWidget {
  const MonthlyfeesMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      spacing: 10.0,
      children: [
        const SizedBox(),
        Container(child: _options()),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsGeometry.all(15),
            child: PageView(
              controller: context.read<MonthlyfeesProvider>().pageController,
              onPageChanged: (index) =>
                  context.read<MonthlyfeesProvider>().onPageChanged(index),
              children: const [
                MonthlyfeesPay(),
                MonthlyfeesHistory(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget _options() {
  return Consumer<MonthlyfeesProvider>(
    builder: (context, provider, _) {
      return CustomTabSwitch(
        tabs: const ['Pagar', 'Historial'],
        selectedIndex: provider.selectedIndex,
        onChanged: (index) => provider.selectTab(index),
      );
    },
  );
}
