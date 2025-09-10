import 'package:cip_payment_web/app/ui/components/button/btn_primary.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_secondary.dart';
import 'package:cip_payment_web/app/ui/components/userlayout/user_layout.dart';
import 'package:cip_payment_web/app/ui/views/proofnodebt/proofnodebt_provider.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProofnodebtView extends StatelessWidget {
  const ProofnodebtView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProofnodebtProvider(),
      child: Builder(
        builder: (context) {
          return UserLayout(
            true,
            child: customPyBefore(context, 'constancia de no adeudo '),
          );
        },
      ),
    );
  }
}

Widget customPyBefore(BuildContext context, String text) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final proofnodebtProvider = Provider.of<ProofnodebtProvider>(
      context,
      listen: false,
    );
    proofnodebtProvider.onInit(context);
  });
  return Container();
}
