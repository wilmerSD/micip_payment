import 'package:cip_payment_web/app/ui/components/custom_tab_switch.dart';
import 'package:cip_payment_web/app/ui/components/userlayout/user_layout.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/monthlyfees_provider.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/widgets/monthlyfees_history.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/widgets/monthlyfees_pay.dart';
import 'package:cip_payment_web/core/helpers/responsive.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class MonthlyfeesView extends StatefulWidget {
  const MonthlyfeesView({super.key});
  @override
  State<MonthlyfeesView> createState() => _MonthlyfeesViewState();
}

class _MonthlyfeesViewState extends State<MonthlyfeesView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final monthlyfeesProvider = Provider.of<MonthlyfeesProvider>(
        context,
        listen: false,
      );
      monthlyfeesProvider.selectTab(0);
      monthlyfeesProvider.fetchPendingPay(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Vista de cuotas mensuales');
    return UserLayout(
      true,
      child: Column(
        // spacing: 10.0,
        children: [
          _customHedaer(context),
          const SizedBox(),
          Expanded(
            child: PageView(
              controller: context.read<MonthlyfeesProvider>().pageController,
              onPageChanged: (index) => context
                  .read<MonthlyfeesProvider>()
                  .onPageChanged(index), // monthlyfeesProvider.onPageChanged,
              children: const [MonthlyfeesPay(), MonthlyfeesHistory()],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _tittle(BuildContext context) {
  return Text(
    'Cuotas Mensuales',
    style: AppTextStyle(context).textTittleContent(),
  );
}

// Widget _options(BuildContext context) {
//   return CustomTabSwitch(
//     tabs: const ['Pagar', 'Historial'],
//     selectedIndex: context.watch<MonthlyfeesProvider>().selectedIndex,
//     onChanged: (index) => context.read<MonthlyfeesProvider>().selectTab(index),
//   );
// }

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

Widget _automaticPay(BuildContext context) {
  return InkWell(
    onTap: () => context.read<MonthlyfeesProvider>().goToAutomaticPay(
      context,
    ), // monthlyfeesProvider.goToAutomaticPay(context),
    child: Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        width: 260.0,
        height: 40.0,
        decoration: const BoxDecoration(
          color: AppColors.secondConst,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            bottomLeft: Radius.circular(50.0),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Afiliate a pago automático',
                style: AppTextStyle(context).bold14(color: Colors.white),
              ),
              const Icon(Bootstrap.box_arrow_up_right, color: Colors.white),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _customHedaer(BuildContext context) {
  return kIsWeb
      ? (Responsive.isDesktop(context)
            ? Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _tittle(context)),
                  Expanded(child: _options()),
                  // Expanded(child: _automaticPay(context)),
                  Expanded(child: SizedBox()),
                ],
              )
            : (Responsive.isTablet(context)
                  ? Column(
                      spacing: 20.0,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: _tittle(context)),
                            // Expanded(child: _automaticPay(context)),
                            Expanded(child: SizedBox()),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: SizedBox()),
                            Expanded(flex: 2, child: _options()),
                            Expanded(child: SizedBox()),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      spacing: 20.0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _tittle(context),
                        // _automaticPay(context),
                        // SizedBox(),
                        _options(),
                      ],
                    )))
      : Column(
          spacing: 20.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tittle(context),
            _automaticPay(context),
            Expanded(child: _automaticPay(context)),
            _options(),
          ],
        );
}
