import 'package:cip_payment_web/app/ui/views/monthlyfees/monthlyfees_provider.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/widgets/nohistory_view.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class MonthlyfeesHistory extends StatelessWidget {
  const MonthlyfeesHistory({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final monthlyfeesProvider = Provider.of<MonthlyfeesProvider>(
        context,
        listen: false,
      );
      monthlyfeesProvider.getHistoryPayment(context);
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: context.watch<MonthlyfeesProvider>().paymentHistoryQuotas.isEmpty
          ? NohistoryView()
          : Column(
              children: [
                // _customContainer(context, 'Mayo 2025',
                //     'Boleta', () {}, 'S/ 30', 'Pagado el 04/06/2025'),
                // _customContainer(context, 'Junio 2025',
                //     'Boleta', () {}, 'S/ 30', 'Pagado el 04/06/2025'),
                // _customContainer(context, 'Julio 2025',
                //     'Boleta', () {}, 'S/ 30', 'Pagado el 04/06/2025'),
                // _customContainer(context, 'Agosto 2025',
                //     'Boleta', () {}, 'S/ 30', 'Pagado el 04/06/2025'),
              ],
            ),
    );
  }
}

Widget _customContainer(
  BuildContext context,
  String tittle,
  String text,
  VoidCallback ontap,
  String textSecond,
  textThird,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        ' ' + tittle,
        style: AppTextStyle(context).bold16(
          fontWeight: FontWeight.w500,
          color: AppColors.textBasic(context),
        ),
      ),
      InkWell(
        onTap: ontap,
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          // height: 70.0,
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
                        style: AppTextStyle(context).bold15(
                          fontWeight: FontWeight.w300,
                          color: AppColors.grayBlue,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        height: 15.0,
                        width: 1.0,
                        color: AppColors.grayBlue,
                      ),
                      Text(
                        textSecond,
                        style: AppTextStyle(context).bold15(
                          fontWeight: FontWeight.w300,
                          color: AppColors.grayBlue,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    textThird,
                    style: AppTextStyle(context).bold15(
                      fontWeight: FontWeight.w300,
                      color: AppColors.grayBlue,
                    ),
                  ),
                ],
              ),
              const Icon(Bootstrap.download, color: AppColors.secondConst),
            ],
          ),
        ),
      ),
      const SizedBox(height: 10.0),
    ],
  );
}
