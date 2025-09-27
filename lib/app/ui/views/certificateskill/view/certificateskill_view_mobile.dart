import 'package:cip_payment_web/app/ui/components/tittle_pay.dart';
import 'package:cip_payment_web/app/ui/views/certificateskill/view/certificateskill_view_desktop.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:flutter/material.dart';

class CertificateSkillViewMobile extends StatelessWidget {
  const CertificateSkillViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15.0,
      children: [
        TittlePay(textCertificateskill),
        const SizedBox(),
        inputCipCertificate(context),
        inputEmailCertificate(context),
        inputStateCertificate(context),
        inputEnabledCertificate(context),
        inputSpecialtyCertificate(context),
        Spacer(),
        customBtnPay(context),
        const SizedBox(height: 10.0),
      ],
    );
  }
}