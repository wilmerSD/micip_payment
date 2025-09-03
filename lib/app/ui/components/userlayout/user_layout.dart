import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/app/ui/components/userlayout/user_header.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserLayout extends StatelessWidget {
  final Widget child;
  final bool withPadding;
  const UserLayout(this.withPadding, {super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor(context),
      body: withPadding
          ?  Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 72.0,
                  ), // Ajusta según la altura del header
                  child: Column(
                    children: [
                      Expanded(
                        child: withPadding
                            ? Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: child,
                              )
                            : child,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 72.0,
                  child: Material(
                    elevation: 1.0,
                    borderRadius: BorderRadius.circular(kRadiusSmall),
                    child: 
                    Consumer<AuthProvider>(builder: (context, provider,_) {
                      // provider.notifyChange();
                      return UserHeader(
                      userName: provider.currentPerson?.namePerson ?? '',
                      cipNumber: provider.currentPerson?.numberCip ?? '',
                      avatarUrl: "https://miapp.com/avatar.jpg",
                    );
                    })
                     
                  ),
                ),
              ],
            )
          :child
    );
  }
}
