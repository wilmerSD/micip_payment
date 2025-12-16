import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/components/dropdown/dropdown_select.dart';
import 'package:cip_payment_web/app/ui/components/dropdown/option_select.dart';
import 'package:cip_payment_web/app/ui/components/fields/custom_text_field.dart';
import 'package:cip_payment_web/app/ui/components/fields/read_only_field.dart';
import 'package:cip_payment_web/app/ui/components/modal_new_note.dart';
import 'package:cip_payment_web/app/ui/components/reciept/select_receipt.dart';
import 'package:cip_payment_web/app/ui/views/certificateskill/certificateskill_provider.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/helpers/responsive.dart';
import 'package:cip_payment_web/domain/entities/speciality.dart';
import 'package:cip_payment_web/infrastructure/models/select_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CertificateskillPay extends StatelessWidget {
  const CertificateskillPay({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final person = authProvider.currentPerson;
    final fullName =
        '${person?.namePerson} ${person?.paternalSurname} ${person?.motherSurname}';
    return Responsive.isDesktop(context)
        ? Column(
            spacing: 15.0,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: inputCipCertificate(
                      context,
                      person?.numberCip ?? '',
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Expanded(child: inputEmailCertificate(context, fullName)),
                  const SizedBox(width: 15.0),
                  Expanded(child: inputStateCertificate(context)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: inputEnabledCertificate(context)),
                  const SizedBox(width: 15.0),
                  Expanded(child: quantityCertificates(context)),
                  const SizedBox(width: 15.0),
                  Expanded(child: inputSpecialtyCertificate(context)),
                ],
              ),
              Spacer(),
              customBtnPay(context),
              // SizedBox(
              //   width: 200,
              //   child: BtnPrimaryInk(
              //     onTap: () async {
              //       final FirebaseFirestore firestoredb =
              //           FirebaseFirestore.instance;

              //       final querySnapshot = await firestoredb
              //           .collection('MemberFee')
              //           .where('feeMonth', isEqualTo: 8)
              //           .where('feeYear', isEqualTo: 2026)
              //           .get();

              //       final batch = firestoredb.batch();

              //       for (final doc in querySnapshot.docs) {
              //         batch.delete(doc.reference);
              //       }

              //       await batch.commit();

              //       debugPrint('✅ Cuotas 08/2026 eliminadas correctamente');
              //     },
              //     text: 'Borrar cuotas generadas 2026',
              //   ),
              // ),
            ],
          )
        : ListView(
            padding: const EdgeInsets.all(15.0),
            children: [
              inputCipCertificate(context, person?.numberCip ?? ''),
              const SizedBox(height: 15.0),
              inputEmailCertificate(context, fullName),
              const SizedBox(height: 15.0),
              inputStateCertificate(context),
              const SizedBox(height: 15.0),
              inputEnabledCertificate(context),
              const SizedBox(height: 15.0),
              quantityCertificates(context),
              const SizedBox(height: 15.0),
              inputSpecialtyCertificate(context),
              const SizedBox(height: 25.0),
              customBtnPay(context),
            ],
          );
  }
}

Widget inputCipCertificate(BuildContext context, String value) {
  return ReadOnlyField(label: 'CIP', value: value);
}

Widget inputEmailCertificate(BuildContext context, String value) {
  return ReadOnlyField(label: "Colegiado", value: value);
}

Widget inputStateCertificate(BuildContext context) {
  final certificateSkill = Provider.of<CertificateSkillProvider>(context);

  String valueText = 'Deshabilitado';
  if (certificateSkill.stateCollegiate) {
    valueText = 'Habilitado';
  }
  return ReadOnlyField(label: "Estado", value: valueText);
}

Widget inputEnabledCertificate(BuildContext context) {
  final certificateSkill = Provider.of<CertificateSkillProvider>(context);
  return ReadOnlyField(
    label: "Habilitado hasta",
    value: certificateSkill.enabledUntil,
  );
}

Widget inputSpecialtyCertificate(BuildContext context) {
  final certificateSkill = Provider.of<CertificateSkillProvider>(context);
  return Select(
    isActive: false,
    label: "Especialidad",
    value: certificateSkill.listSpecialities.isEmpty
        ? null
        : certificateSkill.listSpecialities.firstWhere(
            (element) => element.id == certificateSkill.currectSpecialty.id,
            orElse: () => certificateSkill.listSpecialities.first,
          ),
    items: certificateSkill.listSpecialities.map((element) {
      return DropdownMenuItem(
        value: element,
        child: OptionSelect(
          nameOption: element.nameSpeciality ?? '',
        ), // 👈 mostrar el nombre
      );
    }).toList(),
    onChanged: (newValue) {
      if (newValue != null) {
        certificateSkill.currectSpecialty = SelectModel(
          id: (newValue as Speciality).id ?? '',
          value: newValue.nameSpeciality ?? '',
        );
      }
    },
  );
}

Widget quantityCertificates(BuildContext context) {
  final certificateSkill = Provider.of<CertificateSkillProvider>(context);
  return CustomTextField(
    textInputType: TextInputType.number,
    helperText: 'Cantidad',
    textEditingController: certificateSkill.quantityCertificate,
    inputFormats: [
      FilteringTextInputFormatter.digitsOnly, // ✅ Solo permite números
    ],
    onChanged: (p0) {
      certificateSkill.updateAmount();
    },
  );
}

Widget customBtnPay(BuildContext context) {
  return Consumer<CertificateSkillProvider>(
    builder: (context, provider, _) {
      return SizedBox(
        width: 400.0,
        child: BtnPrimaryInk(
          withIconProgress: false,
          loading:
              provider.haveQuotasPending ||
              provider.amountToPay == 0 ||
              provider.listSpecialities.isEmpty ||
              provider.stateCollegiate == false,
          text: 'Pagar S/. ${provider.amountToPay}',
          onTap: () {
            // provider.prueba();
            ModalUtils.getShowModalBS(
              context,
              content: SelectReceipt(
                mainText: 'Pagar S/. ${provider.amountToPay}',
                textBtn: 'Pagar S/. ${provider.amountToPay}',
                textPopUp: 'Pagar $textCertificateskill',
                content: const SizedBox(),
                onTap: () {
                  provider.openCheckout(
                    context,
                    context.read<AuthProvider>().currentPerson,
                  );
                },
              ),
              title: 'Detalle de pago',
            );
          },
        ),
      );
    },
  );
}

//
