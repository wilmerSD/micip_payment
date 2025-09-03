import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
        margin: const EdgeInsets.only(top: 60.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 45.0,
                  width: 45.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.backgroundColor(context),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grayBlue.withOpacity(0.1),
                        spreadRadius: 4,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    /* onPressed: () {
                      controller.navigateToScreen();
                    }, */
                    icon: Icon(
                      Icons.menu,
                      color: AppColors.primary(context),
                    ),
                  ),
                ),
               /*  Container(
                  height: kSizeNormalLarge.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: kPaddingAppLargeApp.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kRadiusMedium.h),
                    color: AppColors.backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grayBlue.withOpacity(0.1),
                        spreadRadius: 4,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        //textScaler: const TextScaler.linear(1.0),
                        'SemcoCad',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 17,
                            fontWeight: FontWeight.w900),
                            /* AppTextStyle(context)
                                .extra22(color: AppColors.primary) */
                      ),
                      SizedBox(width: kSizeBigLittle.w),

                      
                    ],
                  ),
                ), */
              ],
            ),
          ],
        ),
    );
  }
}
