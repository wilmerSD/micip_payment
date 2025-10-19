import 'package:cip_payment_web/infrastructure/models/month_model.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_secondary.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_third.dart';
import 'package:cip_payment_web/app/ui/components/fields/custom_text_field.dart';
import 'package:cip_payment_web/app/ui/components/dropdown/dropdown_select.dart';
import 'package:cip_payment_web/app/ui/components/dropdown/option_select.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/managequota/manage_quota_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class FormCuotaAll extends StatelessWidget {
  const FormCuotaAll({super.key, required this.manageQuotaProvider});

  final ManageQuotaProvider manageQuotaProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800.0,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Column(
        spacing: 15,
        children: [
          customInfoQuotas(manageQuotaProvider, context),
          const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 20.0,
            children: [
              SizedBox(
                width: 150,
                child: BtnSecondary(
                  text: 'Cancelar',
                  onTap: () => context.pop(),
                ),
              ),
              SizedBox(
                height: 45.0,
                width: 150.0,
                child: BtnThird(text: 'Guardar', onTap: () {
                  manageQuotaProvider.generateQuotasForAllPersons(context);
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget customInfoQuotas(
  ManageQuotaProvider manageQuotaProvider,
  BuildContext context,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    spacing: 30.0,
    children: [
      Expanded(
        child: CustomTextField(
          enabledfield: true,
          helperText: 'Año',
          textEditingController:
              manageQuotaProvider.ctrlAge, // context.read<manageQuotaProvider>,
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
        ),
      ),

      Expanded(
        child: Select(
          isActive: false,
          label: "Mes",
          value: manageQuotaProvider.listMonth.firstWhere(
            (element) => element.id == manageQuotaProvider.currentMonth.id,
          ),
          items: manageQuotaProvider.listMonth.map((element) {
            return DropdownMenuItem(
              value: element,
              child: OptionSelect(nameOption: element.month),
            );
          }).toList(),
          onChanged: (newValue) {
            manageQuotaProvider.currentMonth = newValue as MonthModel;
          },
        ),
      ),
      Expanded(
        child: CustomTextField(
          helperText: 'Monto',
          textEditingController: manageQuotaProvider
              .ctrlAmount, // context.read<manageQuotaProvider>,
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
          initialValue: '20',
          inputFormats: [FilteringTextInputFormatter.digitsOnly],
        ),
      ),
    ],
  );
}
