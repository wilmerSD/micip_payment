import 'package:cip_payment_web/app/ui/components/button/btn_primary.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/components/custom_text_field.dart';
import 'package:cip_payment_web/app/ui/components/modal_new_note.dart';
import 'package:cip_payment_web/app/ui/components/reciept/select_receipt.dart';
import 'package:cip_payment_web/app/ui/views/certificateskill/certificateskill_provider.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/widgets/checkout_monthlyfees.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CertificateSkillViewDesktop extends StatelessWidget {
  const CertificateSkillViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        spacing: 15.0,
        children: [
           
          const SizedBox(),
          Row(
            spacing: 30.0,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: inputCipCertificate(context)),
              Expanded(child: inputEmailCertificate(context)),
              Expanded(child: inputStateCertificate(context)),
              
            ],
          ),
          Row(
            spacing: 30.0,
            children: [
              Expanded(child: inputEnabledCertificate(context)),
              Expanded(child: inputSpecialtyCertificate(context)),
              Expanded(child: SizedBox()),
            ],
          ),
          Spacer(),
          customBtnPay(context),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

Widget inputCipCertificate(BuildContext context) {
  final certificateSkill = Provider.of<CertificateSkillProvider>(context);
  return CustomTextField(
    helperText: 'CIP',
    textInputType: TextInputType.emailAddress,
    textEditingController: certificateSkill.ctrlNumberCip,
  );
}

Widget inputEmailCertificate(BuildContext context) {
  final certificateSkill = Provider.of<CertificateSkillProvider>(context);
  return CustomTextField(
    helperText: "Colegiado",
    textInputType: TextInputType.emailAddress,
    textEditingController: certificateSkill.ctrlColegiado,
  );
}

Widget inputStateCertificate(BuildContext context) {
  final certificateSkill = Provider.of<CertificateSkillProvider>(context);
  return CustomTextField(
    helperText: "Estado",
    textInputType: TextInputType.emailAddress,
    textEditingController: certificateSkill.ctrlState,
  );
}

Widget inputEnabledCertificate(BuildContext context) {
  final certificateSkill = Provider.of<CertificateSkillProvider>(context);
  return CustomTextField(
    helperText: "Habilitado hasta",
    textInputType: TextInputType.emailAddress,
    textEditingController: certificateSkill.ctrlEnabledUntil,
  );
}

Widget inputSpecialtyCertificate(BuildContext context) {
  final certificateSkill = Provider.of<CertificateSkillProvider>(context);
  return CustomTextField(
    helperText: "Especialidad",
    textInputType: TextInputType.emailAddress,
    textEditingController: certificateSkill.ctrlSpecialty,
  );
}

Widget customBtnPay(BuildContext context) {
  final certificateSkill = Provider.of<CertificateSkillProvider>(context);
  return SizedBox(
    width: 400.0,
    child: BtnPrimary(
      withIconProgress: false,
      loading: certificateSkill.haveQuotasPending,
      text: 'Pagar S/ 30.0',
      onTap: () {
        ModalUtils.getShowModalBS(
          context,
          content: const SelectReceipt(
            mainText: 'Pagar S/. 30.0',
            textBtn: 'Continuar',
            textPopUp: 'Pagar certificado de habilidad',
            content: CheckoutMonthlyfees(),
          ),
          title: 'Detalle de pago',
        );
      },
    ),
  );
}
