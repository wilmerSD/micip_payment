import 'package:cip_payment_web/app/models/month_model.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_secondary.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_third.dart';
import 'package:cip_payment_web/app/ui/components/custom_text_field.dart';
import 'package:cip_payment_web/app/ui/components/dropdown/dropdown_select.dart';
import 'package:cip_payment_web/app/ui/components/dropdown/option_select.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/managequota/manage_quota_provider.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/managequota/widgets/from_quotaAll.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/managequota/widgets/list_person.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/person/person_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FormCuota extends StatelessWidget {
  const FormCuota({super.key, required this.manageQuotaProvider});

  final ManageQuotaProvider manageQuotaProvider;

  @override
  Widget build(BuildContext context) {
    final personProvider = Provider.of<PersonProvider>(context, listen: true);

    WidgetsBinding.instance.addPostFrameCallback((_){
      personProvider.getAllPerson();
    });

    return Container(
      width: 800.0,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Column(
        spacing: 15,
        children: [
          SizedBox(
            height: 350,
            child: ListPerson(provider: personProvider)),
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
                child: BtnThird(text: 'Guardar', onTap: () {}),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
