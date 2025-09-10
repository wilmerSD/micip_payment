import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/app/ui/components/userlayout/user_header.dart';
import 'package:cip_payment_web/app/ui/views/home/footer/footer_desktop.dart';
import 'package:cip_payment_web/app/ui/views/home/footer/footer_mobile.dart';
import 'package:cip_payment_web/app/ui/views/home/footer/footer_tablet.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/helpers/responsive.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class UserLayout extends StatelessWidget {
//   final Widget child;
//   final bool withPadding;
//   final bool? withFooter;
//   const UserLayout(
//     this.withPadding, {
//     super.key,
//     required this.child,
//     this.withFooter = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor(context),
//       body: withPadding
//           ? Stack(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     top: 72.0,
//                   ), // Ajusta según la altura del header
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: withPadding
//                             ? Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: child,
//                               )
//                             : child,
//                       ),
//                     ],
//                   ),
//                 ),
//                 if (withFooter!)
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Responsive.isDesktop(context)
//                         ? SizedBox(
//                           height: 350.0,
//                           child: FooterDesktop())
//                         : (Responsive.isTablet(context)
//                               ? SizedBox(
//                                 height: 420.0,
//                                 child: FooterTablet())
//                               : SizedBox(height: 600,
//                                 child: FooterMobile())),
//                   ),

//                 SizedBox(
//                   width: double.infinity,
//                   height: 72.0,
//                   child: Material(
//                     elevation: 1.0,
//                     borderRadius: BorderRadius.circular(kRadiusSmall),
//                     child: Consumer<AuthProvider>(
//                       builder: (context, provider, _) {
//                         // provider.notifyChange();
//                         return UserHeader(
//                           userName: provider.currentPerson?.namePerson ?? '',
//                           cipNumber: provider.currentPerson?.numberCip ?? '',
//                           avatarUrl: "https://miapp.com/avatar.jpg",
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           : child,
//     );
//   }
// }

class UserLayout extends StatelessWidget {
  final Widget child;
  final bool withPadding;
  final bool? withFooter;
  const UserLayout(
    this.withPadding, {
    super.key,
    required this.child,
    this.withFooter = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor(context),
      body: withPadding
          ? Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 72.0,
                  child: Material(
                    elevation: 1.0,
                    borderRadius: BorderRadius.circular(kRadiusSmall),
                    child: Consumer<AuthProvider>(
                      builder: (context, provider, _) {
                        // provider.notifyChange();
                        return UserHeader(
                          userName: provider.currentPerson?.namePerson ?? '',
                          cipNumber: provider.currentPerson?.numberCip ?? '',
                          avatarUrl: "https://miapp.com/avatar.jpg",
                        );
                      },
                    ),
                  ),
                ),
                // SizedBox(height: 5.0,),
                withFooter!
                    ? Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight:
                                      screenHeight *
                                      0.8, // asegura el 80% mínimo
                                ),
                                child: withPadding
                                    ? Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: child,
                                      )
                                    : child,
                              ),
                              if (withFooter!)
                                Responsive.isDesktop(context)
                                    ? FooterDesktop()
                                    : (Responsive.isTablet(context)
                                          ? FooterTablet()
                                          : FooterMobile()),
                            ],
                          ),
                        ),
                      )
                    : withPadding
                    ? Expanded(child: Padding(padding: const EdgeInsets.all(15.0), child: child))
                    : child,
              ],
            )
          : child,
    );
  }
}
