import 'package:cip_payment_web/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_secondary.dart';
import 'package:cip_payment_web/app/ui/components/fields/input_primary.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/courses/course_provider.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/managequota/manage_quota_provider.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/managequota/widgets/form_quota.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/managequota/widgets/from_quotaAll.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/managequota/widgets/table_quota.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageQuotaView extends StatelessWidget {
  const ManageQuotaView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ManageQuotaProvider(),
      child: Builder(
        builder: (context) {
          final manageQuotaProvider = Provider.of<ManageQuotaProvider>(
            context,
            listen: false,
          );

          // Se ejecuta solo una vez cuando se construye el widget
          WidgetsBinding.instance.addPostFrameCallback((_) {
            manageQuotaProvider.getGeneratedPayments();
          });
          return Consumer<ManageQuotaProvider>(
            builder: (context, manageQuotaProvider, _) {
              return Scaffold(
                backgroundColor: AppColors.backgroundColor(context),
                body: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    spacing: 20.0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 20.0,
                        children: [
                          SizedBox(
                            width: 200.0,
                            child: BtnPrimaryInk(
                              text: 'Generar cuota',
                              onTap: () {
                                // courseProvider.cleanVars();
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return PopupGeneral(
                                      title: 'Generar cuota',
                                      onTapButton: () {},
                                      scrollable: false,
                                      content: FormCuota(
                                        manageQuotaProvider:
                                            manageQuotaProvider,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 250,
                            child: BtnSecondary(
                              text: 'Generar a todos los colegiados',
                              onTap: () => showDialog(
                                context: context,
                                builder: (context) {
                                  return PopupGeneral(
                                    title: 'Generar cuota a todos los colegiados',
                                    onTapButton: () {},
                                    scrollable: true,
                                    content: FormCuotaAll(
                                      manageQuotaProvider: manageQuotaProvider,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      // _seeker(context, manageQuotaProvider),
                      Expanded(
                        child: TableQuota(provider: manageQuotaProvider),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

Widget _seeker(BuildContext context, CourseProvider courseProvider) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    height: 100.0,
    decoration: BoxDecoration(
      color: AppColors.backgroundColor(context),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.07),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 1), // changes position of shadow
        ),
      ],
    ),
    child: Row(
      spacing: 30.0,
      children: [
        Expanded(
          child: InputPrimary(
            label: "Nombre",
            textEditingController: courseProvider.ctrlNameCourse,
            // inputFormats: [
            //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            // ],
            // maxLength: personProvider.typeDocument.value == 0 ? 8 : null,
          ),
        ),
        Expanded(
          child: InputPrimary(
            label: "Tipo",
            textEditingController: courseProvider.ctrlNameCourse,
            // inputFormats: [
            //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            // ],
            // maxLength: personProvider.typeDocument.value == 0 ? 8 : null,
          ),
        ),
        Expanded(
          child: InputPrimary(
            label: "Externo",
            textEditingController: courseProvider.ctrlNameCourse,
            // inputFormats: [
            //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            // ],
            // maxLength: personProvider.typeDocument.value == 0 ? 8 : null,
          ),
        ),
        SizedBox(
          width: 150.0,
          child: BtnSecondary(
            text: 'Limpiar',
            onTap: () => courseProvider.cleanSearch(),
          ),
        ),
      ],
    ),
  );
}
