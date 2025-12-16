import 'package:cip_payment_web/app/ui/components/userlayout/user_layout.dart';
import 'package:cip_payment_web/app/ui/views/advancepayment/advancepayment_provider.dart';
import 'package:cip_payment_web/app/ui/views/advancepayment/views/advancepayment_desktop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdvancepaymentView extends StatelessWidget {
  const AdvancepaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final advancepaymentProvider = Provider.of<AdvancepaymentProvider>(
        context,
        listen: false,
      );
      advancepaymentProvider.onInit(context);
    });

    return UserLayout(true, child: AdvancepaymentDesktop());
  }
}
