import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/components/fields/read_only_field.dart';
import 'package:cip_payment_web/app/ui/components/modal_new_note.dart';
import 'package:cip_payment_web/app/ui/components/reciept/select_receipt.dart';
import 'package:cip_payment_web/app/ui/views/proofnodebt/proofnodebt_provider.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/helpers/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProofnodebtPay extends StatelessWidget {
  const ProofnodebtPay({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final person = authProvider.currentPerson;
    final fullName =
        '${person?.namePerson} ${person?.paternalSurname} ${person?.motherSurname}';
    return Responsive.isDesktop(context) ? 
    Column(
      spacing: 20.0,
      children: [
        Row(
          spacing: 20.0,
          children: [
            Expanded(child: _textFieldCip(person?.numberCip ?? '')),
            SizedBox(width: 15.0),
            Expanded(child: _textFieldCollege(fullName)),
            SizedBox(width: 15.0),
            Expanded(child: _textFieldState(context)),
          ],
        ),
        Row(
          children: [
            Expanded(child: _textFieldEnabledUntil(context)),
            Expanded(flex: 2, child: SizedBox()),
          ],
        ),
        const Spacer(),
        _btnPay(context),
      ],
    ) : ListView(
      children: [
        _textFieldCip(person?.numberCip ?? ''),
        SizedBox(height: 15.0),
        _textFieldCollege(fullName),
        SizedBox(height: 15.0),
        _textFieldState(context),
        SizedBox(height: 15.0),
        _textFieldEnabledUntil(context),
        SizedBox(height: 25.0),
        _btnPay(context),
        // const SizedBox()
      ],
    );
  }
}

Widget _textFieldCip(String value) {
  return ReadOnlyField(label: 'Cip', value: value);
}

Widget _textFieldCollege(String value) {
  return ReadOnlyField(label: 'Colegiado', value: value);
}

Widget _textFieldState(BuildContext context) {
  final proofnodebtProvider = Provider.of<ProofnodebtProvider>(context);
  String valueText = 'Deshabilitado';
  if (proofnodebtProvider.stateCollegiate) {
    valueText = 'Habilitado';
  }

  return ReadOnlyField(label: 'Estado', value: valueText);
}

Widget _textFieldEnabledUntil(BuildContext context) {
  final proofnodebtProvider = Provider.of<ProofnodebtProvider>(context);
  return ReadOnlyField(
      label: 'Habilitado hasta', value: proofnodebtProvider.enabledUntil);
}

Widget _btnPay(BuildContext context) {
   
  return Consumer<ProofnodebtProvider>(builder: (context, provider, _) {
    return SizedBox(
      width: 400.0,
      child: BtnPrimaryInk(
        withIconProgress: false,
        loading: provider.haveQuotasPending || provider.stateCollegiate == false,
        text: 'Pagar S/. ${provider.amountToPay}',
        onTap: () {
          // provider.prueba();
          ModalUtils.getShowModalBS(
            context,
            content: SelectReceipt(
              mainText: 'Pagar S/. ${provider.amountToPay}',
              textBtn: 'Pagar S/. ${provider.amountToPay}',
              textPopUp: 'Pagar $textProofnodebt',
              content: const SizedBox(),
              onTap: () {
                provider.openCheckout(context, context.read<AuthProvider>().currentPerson);
              },
            ),
            title: 'Detalle de pago',
          );
        },
      ),
    );
  });
}
