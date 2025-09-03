import 'package:cip_payment_web/app/ui/components/button/btn_secondary.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_third.dart';
import 'package:cip_payment_web/app/ui/views/iepi/iepi_controller.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/widgets/custom_tittle_appbar.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/widgets/leading.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class IepiView extends StatelessWidget {
  const IepiView({super.key});

  @override
  Widget build(BuildContext context) {
    final iepiController = Provider.of<IepiProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(context),
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor(context),
        surfaceTintColor: Colors.transparent,
        leading: const Leading(),
        title: const CustomTittleAppbar(
          tittle: 'Instituto de Estudios Profesionales de Ingeniería IEPI',
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.info_outline), // Cambiado de Icons.abc
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: [
            const SizedBox(height: 50),
            containerCourse(
              context,
              'Metrados y cálculo de materiales de construcción',
              'Curso de especialidad',
              'Virtual',
              'https://picsum.photos/id/237/400/200',
              () {
                context.push(AppRoutesName.DETAILCOURSE);
              },
              () {},
            ),
            const SizedBox(height: 25.0),
            containerCourse(
              context,
              'Solidworks desde cero',
              'Curso de especialidad',
              'Virtual',
              'https://picsum.photos/id/237/400/200',
              () {
                context.push(AppRoutesName.DETAILCOURSE);
              },
              () {},
            ),
          ],
        ),
      ),
    );
  }
}

Widget containerCourse(
  BuildContext context,
  String tittle,
  String subtittle,
  String modality,
  String routeImage,
  Function() onMoreinf,
  Function() onEnroll,
) {
  return Container(
    height: 380.0,
    decoration: BoxDecoration(
      color: AppColors.backgroundColor(context),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.09),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 1),
        ),
      ],
    ),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: Container(
            height: 180.0,
            color: Colors.amber,
            child: Image.network(
              routeImage,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tittle,
                style: AppTextStyle(context).bold17(),
              ),
              const SizedBox(height: 6.0),
              Text(
                subtittle,
                style:
                    AppTextStyle(context).bold14(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4.0),
              Text(
                modality,
                style:
                    AppTextStyle(context).bold14(fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: BtnSecondary(
                      text: 'Mas información',
                      onTap: onMoreinf,
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: BtnThird(
                      text: 'Matricularme',
                      onTap: onEnroll,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        )
      ],
    ),
  );
}
