import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class CourseExplore extends StatelessWidget {
const CourseExplore({ super.key });

  @override
  Widget build(BuildContext context){
    return Container(
    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
    decoration: BoxDecoration(
        gradient: AppColors.coursesGradient,
        borderRadius: BorderRadius.circular(8.0)),
    child: Column(
      // spacing: 10.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Explorar cursos',
          style: AppTextStyle(context).bold24(color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              spacing: 15.0,
              children: [
                Container(
                  width: 100,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                SizedBox(
                  height: 75.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Metrados y cálculo de materiales de construcción',
                        style:
                            AppTextStyle(context).bold14(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Curso de Especialidad',
                        style:
                            AppTextStyle(context).bold14(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Virtual',
                        style:
                            AppTextStyle(context).bold14(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              spacing: 15.0,
              children: [
                Container(
                  width: 100,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                SizedBox(
                  height: 75.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Solids works desde cero',
                        style:
                            AppTextStyle(context).bold14(color: Colors.white),
                      ),
                      Text(
                        'Curso de Especialidad',
                        style:
                            AppTextStyle(context).bold14(color: Colors.white),
                      ),
                      Text(
                        'Presencial',
                        style:
                            AppTextStyle(context).bold14(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              spacing: 10.0,
              children: [
                SizedBox(
                  width: 160,
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 65,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      Positioned(
                        left: 30,
                        child: Container(
                          width: 100,
                          height: 65,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                      ),
                      Positioned(
                        left: 60,
                        child: Container(
                          width: 100,
                          height: 65,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.primaryConst,
                  ),
                  height: 40.0,
                  width: 160,
                  child: const Center(
                      child: Text(
                    'Ver todos',
                    style: TextStyle(color: Colors.white),
                  )),
                )
              ],
            )
          ],
        )
      ],
    ),
  );
  }
}