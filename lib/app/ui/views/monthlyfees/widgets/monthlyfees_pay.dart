import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/monthlyfees_provider.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/widgets/nodebt_view.dart';
import 'package:cip_payment_web/core/helpers/helpers.dart';
import 'package:cip_payment_web/core/helpers/responsive.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyfeesPay extends StatelessWidget {
  const MonthlyfeesPay({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Hola MonthlyfeesPay');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: context.watch<MonthlyfeesProvider>().isGettingPendingPay
          ? Center(child: CircularProgressIndicator())
          : context.read<MonthlyfeesProvider>().listQuotas.isEmpty
          ? NodebtView()
          : Column(
              spacing: 10.0,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    children: [
                      Consumer<MonthlyfeesProvider>(
                        builder: (context, provider, _) {
                          return Checkbox(
                            value: provider.allSelected,
                            onChanged: (bool? value) {
                              provider.toggleSelectAll();
                            },
                          );
                        },
                      ),
                      Text(
                        'Seleccionar todo',
                        style: AppTextStyle(context).bold13(),
                      ),
                    ],
                  ),
                ),
                Consumer<MonthlyfeesProvider>(
                  builder: (context, provider, _) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Wrap(
                          spacing: 30.0,
                          runSpacing: 10.0,
                          children: List.generate(provider.listQuotas.length, (
                            index,
                          ) {
                            final fee = provider.listQuotas[index];
                            return _customContainer(
                              context,
                              Checkbox(
                                value: fee.isSelected,
                                onChanged: (value) {
                                  provider.togglePaid(index, value ?? false);
                                },
                              ),
                              'Cuota ordinaria',
                              () {
                                provider.togglePaid(index, !fee.isSelected);
                              },
                              '${Helpers.getNameMonth(fee.feeMonth ?? 0)} ${fee.feeYear}',
                              'S/ ${fee.amount}',
                            );
                          }),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 400.0,
                  child: Consumer<MonthlyfeesProvider>(
                    builder: (context, provider, _) {
                      return BtnPrimaryInk(
                        withIconProgress: false,
                        loading: provider.totalSelected == 0,
                        text: 'Pagar S/. ${provider.totalSelected}',
                        onTap: () async {
                          // ModalUtils.getShowModalBS(
                          //   context,
                          //   content: SelectReceipt(
                          //     mainText: 'Pagar S/. ${provider.totalSelected}',
                          //     textBtn: 'Continuar',
                          //     textPopUp: 'Pagar cuota mensual',
                          //     content:  CheckoutMonthlyfees(),
                          //   ),
                          //   title: 'Detalle de pago',
                          // );
                          context.read<MonthlyfeesProvider>().prueba();
                          // context.read<MonthlyfeesProvider>().openCheckout(context);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
    );
  }
}

Widget _customContainer(
  BuildContext context,
  Widget icon,
  String text,
  VoidCallback ontap,
  String textSecond,
  textThird,
) {
  return InkWell(
    onTap: ontap,
    borderRadius: BorderRadius.circular(10.0),
    child: Container(
      width: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? 320.0
          : double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color.fromARGB(92, 249, 249, 250),
        border: Border.all(color: const Color.fromRGBO(232, 242, 250, 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: AppTextStyle(context).bold16(
                      // fontWeight: FontWeight.w500,
                      color: AppColors.textBasic(context),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    height: 15.0,
                    width: 1.0,
                    color: AppColors.textBasic(context),
                  ),
                  Text(textSecond),
                ],
              ),
              Text(textThird),
            ],
          ),
          icon,
        ],
      ),
    ),
  );
}


          // Expanded(
          //   child: GridView.builder(
          //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          //       mainAxisExtent: 100,
          //       maxCrossAxisExtent: 200, // cada item mide máx 200px de ancho
          //       crossAxisSpacing: 10,
          //       mainAxisSpacing: 10,
          //     ),
          //     itemCount: 3,
          //     itemBuilder: (context, index) {
          //       return Container(
          //         alignment: Alignment.center,
          //         color: Colors.teal,
          //         child: Text('Item $index'),
          //       );
          //     },
          //   ),
          // ),
          // Expanded(
          //   child: GridView.count(
          //     shrinkWrap:
          //         true, // importante si lo usas dentro de un SingleChildScrollView
          //     crossAxisCount:
          //         3, // cantidad de columnas (en pantallas grandes se verán 3)
          //     crossAxisSpacing: 10,
          //     mainAxisSpacing: 10,
          //     childAspectRatio: 3, // ajusta el ancho/alto de cada item
          //     children: [
          //       _customContainer(
          //         context,
          //         Checkbox(value: true, onChanged: (value) {}),
          //         'Cuota ordinaria',
          //         () {},
          //         'Abril 2025',
          //         'S/ 30',
          //       ),
          //       _customContainer(
          //         context,
          //         Checkbox(value: false, onChanged: (value) {}),
          //         'Cuota ordinaria',
          //         () {},
          //         'Mayo 2025',
          //         'S/ 30',
          //       ),
          //       _customContainer(
          //         context,
          //         Checkbox(value: false, onChanged: (value) {}),
          //         'Cuota ordinaria',
          //         () {},
          //         'Junio 2025',
          //         'S/ 30',
          //       ),
          //     ],
          //   ),
          // ),

          // Expanded(
          //   child: GridView.extent(
          //     shrinkWrap: true,
          //     maxCrossAxisExtent: 350, // cada item mide como máximo 250px
          //     crossAxisSpacing: 10,
          //     mainAxisSpacing: 10,
          //     childAspectRatio: 4,

          //     children: [
          //       _customContainer(
          //         context,
          //         Checkbox(value: true, onChanged: (value) {}),
          //         'Cuota ordinaria',
          //         () {},
          //         'Abril 2025',
          //         'S/ 30',
          //       ),
          //       _customContainer(
          //         context,
          //         Checkbox(value: false, onChanged: (value) {}),
          //         'Cuota ordinaria',
          //         () {},
          //         'Mayo 2025',
          //         'S/ 30',
          //       ),
          //       _customContainer(
          //         context,
          //         Checkbox(value: false, onChanged: (value) {}),
          //         'Cuota ordinaria',
          //         () {},
          //         'Junio 2025',
          //         'S/ 30',
          //       ),
          //     ],
          //   ),
          // ),


          //   Consumer<MonthlyfeesProvider>(
          //     builder: (context, provider, _) {
          //       return Expanded(
          //         child: ListView.builder(
          // itemCount: provider.listQuotas.length,
          // itemBuilder: (context, index) {
          //   final fee = provider.listQuotas[index];
          //   return _customContainer(
          //                 context,
          //                 Checkbox(
          //                   value: false,
          //                   onChanged: (value) {
          //                     // provider.togglePaid(index, value ?? false);
          //                   },
          //                 ),
          //                 'Cuota ordinaria',
          //                 () {},
          //                 '${Helpers.getNameMonth(fee.feeMonth ?? 0)} ${fee.feeYear}',
          //                 'S/ ${fee.amount}',
          //               );
          //             },
          //           ),

          //       );
          //     },
          //   ),