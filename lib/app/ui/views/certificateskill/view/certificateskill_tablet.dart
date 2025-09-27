import 'package:cip_payment_web/app/ui/components/tittle_pay.dart';
import 'package:cip_payment_web/app/ui/views/certificateskill/view/certificateskill_view_desktop.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:flutter/material.dart';

class CertificateSkillViewTablet extends StatelessWidget {
  const CertificateSkillViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        spacing: 15.0,
        children: [
          TittlePay(textCertificateskill),
          const SizedBox(),
          Row(
            spacing: 30.0,
            children: [
              Expanded(child: inputCipCertificate(context)),
              Expanded(child: inputEmailCertificate(context)),
            ],
          ),
          Row(
            spacing: 30.0,
            children: [
              Expanded(child: inputStateCertificate(context)),
              Expanded(child: inputEnabledCertificate(context)),
            ],
          ),
          Row(
            spacing: 30.0,
            children: [
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
