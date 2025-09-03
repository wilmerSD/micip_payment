import 'package:cip_payment_web/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_web/app/ui/components/datatable2.dart';
import 'package:cip_payment_web/app/ui/components/icon_wrapper.dart';
import 'package:cip_payment_web/app/ui/components/table_primary.dart';
import 'package:cip_payment_web/app/ui/components/wrapper/wrapper_datatable.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/courses/course_provider.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/courses/widgets/form_course.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/helpers/helpers.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class TableCourse extends StatelessWidget {
  const TableCourse({
    super.key,
    required this.provider,
  });
  final CourseProvider provider;

  @override
  Widget build(BuildContext context) {
    // final custom.ColumnSize? columnSize
    return WrapperDatatable(
      Column(
        children: [
          Expanded(
            child: TablePrimary(
              minWidth: minWidthNormalTable,
              columns: [
                CustomColumn("#", columnSize: ColumnSize.XXS, isCenter: true),
                CustomColumn("Nombre", columnSize: ColumnSize.S),
                CustomColumn("Fecha inicio", columnSize: ColumnSize.XS),
                CustomColumn("Fecha fin", columnSize: ColumnSize.XS),
                CustomColumn("Total horas", columnSize: ColumnSize.S),
                CustomColumn("Modalidad", columnSize: ColumnSize.XS),
                CustomColumn("Estado", columnSize: ColumnSize.XS),
                CustomColumn(
                  "Acciones",
                  columnSize: ColumnSize.XS,
                  isCenter: true,
                )
              ].where((element) => !element.isObscure!).toList(),
              rows: List<CustomRow>.generate(
                provider.listCourses.length,
                (index) {
                  final item = provider.listCourses[index];
                  return CustomRow(
                    context,
                    cells: [
                      CustomCell("",
                          context,
                          isText: false,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(index.toString()))),
                      CustomCell(item.nameCourse ?? '', context,),
                      CustomCell(Helpers.timestampToString(item.startDateCourse ?? Timestamp.now()),context,),
                      CustomCell(
                          Helpers.timestampToString(item.endDateCourse ?? Timestamp.now()),context,),
                      CustomCell(item.totalTimeHours.toString(),context,),
                      CustomCell(item.modalityCourse.toString(),context,), //  == 0 ?? 'Presencial' : 'Virtual'),
                      CustomCell('',context,
                          isText: false,
                          child:
                      customState(context,item.stateCourse ?? false)
                      ),
                      CustomCell('',context, isText: false, child:
                           IconWrapper(
                            onTap: () {
                              provider.equalVarToEdit(item);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return PopupGeneral(
                                      title: 'Ingresar persona',
                                      onTapButton: () {},
                                      scrollable: true,
                                      content:
                                      FormCourse(courseProvider: provider,));
                                },
                              );
                            },
                            child: const Tooltip(
                              message: 'Editar',
                              child: Icon(Iconsax.edit_outline,
                                  color: AppColors.primaryConst,
                                  size: kSizeBigLittle),
                            ),
                          ),
                          ),
                    ].where((element) => !element.isObscure!).toList(),
                  );
                },
              ),
            ),
          ),
          provider.listCourses.isEmpty
              ? const SizedBox()
              : Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kPaddingAppLittleApp),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '',
                        /* "${(controller.page - 1) * kSizePage + 1} - ${(controller.page - 1) * kSizePage + controller.usersList.length} de ${controller.countPage} registro(s)", */
                        /* "${controller.pageIndex} - ${controller.countPage} de ${controller.countItem} registro(s)", */
                        // "Registros por pág: ${controller.countItem} | ${controller.pageIndex} - ${controller.countPage} páginas",
                        style: TextStyle(
                            color: AppColors.grayMiddle,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300),
                      ),

                      const SizedBox(width: kSizeNormalLittle),
                      Row(children: [
                        const SizedBox(
                          width: kSizeNormalLittle,
                        ),

                        //  PaginatorButton(
                        //     isBack: true,
                        //     isActive: controller.pageIndex > 1,
                        //     onTap: () {
                        //       controller.page--;
                        //       controller.listUserFilter(true);
                        //     },
                      ]),
                      const SizedBox(
                        width: kSizeLittle,
                      ),

                      // PaginatorButton(
                      //   isBack: false,
                      //   isActive: controller.pageIndex <
                      //       controller.countPage.value,
                      //   onTap: () {
                      //     controller.page++;
                      //     controller.listUserFilter(true);
                      //   },

                      // ),
                    ],
                  ))
        ],
      ),
    );
  }
}

Widget customState(BuildContext context, bool state) {
  return Container(
      width: kSizekSizeSmallBigWeb,
      height: 30.0,
      // padding: const EdgeInsets.symmetric(
      //    /*  horizontal: kPaddingAppLittleApp, */ vertical: 3.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadiusBetweenMedionAndNormal),
          color: state ? AppColors.stateActive : AppColors.stateInactive),
      child: Center(
        child: Text(
          state ? 'Activo' : 'Inactivo',
          style: TextStyle(color: AppColors.backgroundColor(context)),
        ),
      ));
}
