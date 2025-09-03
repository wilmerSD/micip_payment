import 'package:cip_payment_web/app/ui/components/datatable2.dart';
import 'package:cip_payment_web/app/ui/components/icon_wrapper.dart';
import 'package:cip_payment_web/app/ui/components/table_primary.dart';
import 'package:cip_payment_web/app/ui/components/wrapper/wrapper_datatable.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/managequota/manage_quota_provider.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/helpers/helpers.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class TableQuota extends StatelessWidget {
  const TableQuota({
    super.key,
    required this.provider,
  });
  final ManageQuotaProvider provider;

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
                CustomColumn("DNI", columnSize: ColumnSize.XS),
                CustomColumn("Monto", columnSize: ColumnSize.XS),
                CustomColumn("Mes", columnSize: ColumnSize.S),
                CustomColumn("Año", columnSize: ColumnSize.XS),
                CustomColumn("Estado", columnSize: ColumnSize.XS),
                CustomColumn(
                  "Acciones",
                  columnSize: ColumnSize.XS,
                  isCenter: true,
                )
              ].where((element) => !element.isObscure!).toList(),
              rows: List<CustomRow>.generate(
                provider.listQuotas.length,
                (index) {
                  final item = provider.listQuotas[index];
                  return CustomRow(
                    context,
                    cells: [
                      CustomCell("",context,
                          isText: false,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(index.toString()))),
                      CustomCell(item.namePerson ?? '',context,),
                      CustomCell('${item.paternalSurname}  ${item.motherSurname}',context,),
                      CustomCell(item.amount.toString(),context,),
                      CustomCell(Helpers.getNameMonth(item.feeMonth ?? 0), context,),
                      CustomCell(item.feeYear.toString(),context,),
                      CustomCell('',context,
                          isText: false,
                          child:
                      customState(context,item.status ?? '')
                      ),
                      CustomCell('',context, isText: false, child:
                           IconWrapper(
                            onTap: () {
                              // provider.equalVarToEdit(item);
                              // showDialog(
                              //   context: context,
                              //   builder: (context) {
                              //     return PopupGeneral(
                              //         title: 'Ingresar persona',
                              //         onTapButton: () {},
                              //         scrollable: true,
                              //         content:
                              //         FormCuota(courseProvider: provider,));
                              //   },
                              // );
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
          provider.listQuotas.isEmpty
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

Widget customState(BuildContext context, String state) {
  return Container(
      width: kSizekSizeSmallBigWeb,
      height: 30.0,
      // padding: const EdgeInsets.symmetric(
      //    /*  horizontal: kPaddingAppLittleApp, */ vertical: 3.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadiusBetweenMedionAndNormal),
          color: state == 'paid' ? AppColors.stateActive : state == 'pending' ? AppColors.orange :  AppColors.stateInactive),
      child: Center(
        child: Text(
          state,
          style: TextStyle(color: AppColors.backgroundColor(context)),
        ),
      ));
}
