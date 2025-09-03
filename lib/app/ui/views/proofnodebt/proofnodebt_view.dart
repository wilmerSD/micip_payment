import 'package:cip_payment_web/app/ui/components/button/btn_primary.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_secondary.dart';
import 'package:cip_payment_web/app/ui/components/userlayout/user_layout.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProofnodebtView extends StatelessWidget {
  const ProofnodebtView({super.key});

  @override
  Widget build(BuildContext context) {
    return UserLayout(
      true,
      child: customPyBefore(context, 'constancia de no adeudo '),
    );
  }
}

Widget customPyBefore(BuildContext context, String text) {
  return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            height: 150,
            width: 600,
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.backgroundColor(context),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.07),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              spacing: 15.0,
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Para poder emitir su ',
                        style: AppTextStyle(
                          context,
                        ).bold18(fontWeight: FontWeight.w300),
                      ),
                      TextSpan(
                        text: text ,
                        style: AppTextStyle(context).bold18(),
                      ),
                      TextSpan(
                        text: 'debe pagar sus cuotas pendientes',
                        style: AppTextStyle(
                          context,
                        ).bold18(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 15.0,
                  children: [
                    Expanded(child: SizedBox()),
                    Expanded(
                      child: BtnSecondary(
                        text: 'Volver',
                        onTap: () => context.go(AppRoutesName.HOME),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 47.0,
                        child: BtnPrimary(
                          text: 'Ir a pagar',
                          onTap: () =>
                              context.go(AppRoutesName.MONTHLYFEES),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}