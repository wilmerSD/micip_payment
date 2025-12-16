import 'package:cip_payment_web/app/ui/components/userlayout/user_layout.dart';
import 'package:cip_payment_web/app/ui/views/proofnodebt/proofnodebt_provider.dart';
import 'package:cip_payment_web/app/ui/views/proofnodebt/view/proofnodebt_view_desktop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProofnodebtView extends StatelessWidget {
  const ProofnodebtView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final proofnodebtProvider = Provider.of<ProofnodebtProvider>(
        context,
        listen: false,
      );
      proofnodebtProvider.onInit(context);
    });

    return UserLayout(
      true,
      child: ProofnodebtViewDesktop()
    );
  }
}
