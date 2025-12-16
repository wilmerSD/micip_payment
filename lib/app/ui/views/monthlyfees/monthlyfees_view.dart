import 'package:cip_payment_web/app/ui/components/userlayout/user_layout.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/monthlyfees_provider.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/view/monthlyfees_view_desktop.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/view/monthlyfees_view_mobile.dart';
import 'package:cip_payment_web/core/helpers/responsive.dart';
import 'package:flutter/material.dart';
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
      monthlyfeesProvider.onInit(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Vista de cuotas mensuales');
    return UserLayout(
      true,
      child: Responsive.isDesktop(context)
          ? MonthlyfeesViewDesktop()
          : MonthlyfeesMobile(),
    );
  }
}
