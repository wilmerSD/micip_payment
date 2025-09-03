import 'package:cip_payment_web/app/ui/components/button/btn_primary.dart';
import 'package:cip_payment_web/app/ui/views/layout/routeDataTemporary.dart';
import 'package:cip_payment_web/core/helpers/responsive.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context) || Responsive.isTablet(context)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Opps...",
                style: AppTextStyle(context)
                    .bold30(color: AppColors.grayBlue),
              ),
              SizedBox(
                child:  Lottie.asset('assets/Lonely404.json',repeat: false),
              
              ),
              const SizedBox(height: 10.0),
              Text(
                message,
                style: AppTextStyle(context).bold20(),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: 150.0,
                child: BtnPrimary(
                  text: "Ir a inicio",
                  onTap: () {
                    RouteDataTemporary.currentRoute = AppRoutesName.DASHBOARD;
                  },
                ),
              )
            ],
          )
        : ListView(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Opps...",
                    style: AppTextStyle(context)
                        .bold30(color: AppColors.grayBlue),
                  ),
                  const SizedBox(
                    child: Image(
                      image: AssetImage("assets/img/error404.png"),
                      width: 520.0,
                      height: 350.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    message,
                    style: AppTextStyle(context).bold20(),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    width: 150.0,
                    child: BtnPrimary(
                      text: "Ir a inicio",
                      onTap: () {
                        RouteDataTemporary.currentRoute = AppRoutesName.HOME;
                      },
                    ),
                  )
                ],
              ),
          ],
        );
  }
}
