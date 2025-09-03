import 'package:cip_payment_web/app/ui/components/datatable2.dart';
import 'package:cip_payment_web/app/ui/components/table_primary.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/person/person_provider.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
class ListPerson extends StatelessWidget {
  const ListPerson({super.key, required this.provider});
  final PersonProvider provider;

  @override
  Widget build(BuildContext context) {
    // final custom.ColumnSize? columnSize
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      // padding: const EdgeInsets.all(kPaddingAppMediunApp),
      child: Column(
        children: [
          Expanded(
            child: TablePrimary(
              minWidth: 400,
              columns: [
                CustomColumn(
                  '',
                  isText: false,
                  child: Checkbox(value: false, onChanged: (_) {}),
                  columnSize: ColumnSize.XXS,
                  isCenter: true,
                ),
                CustomColumn("Nombres completos", columnSize: ColumnSize.S),
                CustomColumn("DNI", columnSize: ColumnSize.XS),
                CustomColumn("Nro CIP", columnSize: ColumnSize.XS),
                CustomColumn("Estado", columnSize: ColumnSize.XS),
              ].where((element) => !element.isObscure!).toList(),
              rows: List<CustomRow>.generate(provider.listPersons.length, (
                index,
              ) {
                final item = provider.listPersons[index];
                return CustomRow(
                  context,
                  cells: [
                    CustomCell(
                      "",context,
                      isText: false,
                      child: Center(
                        child: Checkbox(value: false, onChanged: (_) {}),
                      ),
                    ),
                    CustomCell(
                      item.namePerson +
                          item.paternalSurname +
                          item.motherSurname,context,
                    ),
                    CustomCell(item.dni,context,),
                    CustomCell(item.numberCip,context,),
                    CustomCell(
                      '',context,
                      isText: false,
                      child: customState(context, item.statePerson),
                    ),
                  ].where((element) => !element.isObscure!).toList(),
                );
              }),
            ),
          ),
          provider.listPersons.isEmpty
              ? const SizedBox()
              : Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kPaddingAppLittleApp,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '',
                        /* "${(controller.page - 1) * kSizePage + 1} - ${(controller.page - 1) * kSizePage + controller.usersList.length} de ${controller.countPage} registro(s)", */
                        /* "${controller.pageIndex} - ${controller.countPage} de ${controller.countItem} registro(s)", */
                        // "Registros por pág: ${controller.countItem} | ${controller.pageIndex} - ${controller.countPage} páginas",
                        style: const TextStyle(
                          color: AppColors.grayMiddle,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),

                      const SizedBox(width: kSizeNormalLittle),
                      Row(
                        children: [
                          const SizedBox(width: kSizeNormalLittle),

                          //  PaginatorButton(
                          //     isBack: true,
                          //     isActive: controller.pageIndex > 1,
                          //     onTap: () {
                          //       controller.page--;
                          //       controller.listUserFilter(true);
                          //     },
                        ],
                      ),
                      const SizedBox(width: kSizeLittle),

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
                  ),
                ),
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
      color: state ? AppColors.stateActive : AppColors.stateInactive,
    ),
    child: Center(
      child: Text(
        state ? 'Activo' : 'Inactivo',
        style: TextStyle(color: AppColors.backgroundColor(context)),
      ),
    ),
  );
}
