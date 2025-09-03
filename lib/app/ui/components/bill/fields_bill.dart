import 'package:cip_payment_web/app/providers/bill_provider.dart';
import 'package:cip_payment_web/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FieldsBill extends StatelessWidget {
  const FieldsBill(
      {super.key,
      required this.textBtn,
      required this.textPopUp,
      required this.content});
  final String textBtn;
  final String textPopUp;
  final Widget content;
  @override
  Widget build(BuildContext context) {
    final billProvider = Provider.of<BillProvider>(context);
    /* 📌 Input ruc */
    Widget inputRuc = CustomTextField(
      helperText: 'Ruc',
      textEditingController: billProvider.ctrlRuc,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

    Widget inputCompanyName = CustomTextField(
      helperText: 'Razón social',
      textEditingController: billProvider.ctrlCompanyName,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

    Widget inputIndustry = CustomTextField(
      helperText: 'Giro, Industria',
      textEditingController: billProvider.ctrlIndustry,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

    Widget inputAddress = CustomTextField(
      helperText: 'Dirección',
      textEditingController: billProvider.ctrlAddress,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

    Widget inputDepartment = CustomTextField(
      helperText: 'Departamento',
      textEditingController: billProvider.ctrlDepartment,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

    Widget inputDistrict = CustomTextField(
      helperText: 'Distrito',
      textEditingController: billProvider.ctrlDistrict,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        // Lógica para validar el formulario
      },
    );

    /* 📌 Botón de pago */
    Widget btnPay = BtnPrimaryInk(
      text: textBtn,
      onTap: () {
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return PopupGeneral(
        //       onTapButton: () => {},
        //       title: textPopUp,
        //       content: content,
        //     );
        //   },
        // );
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        spacing: 20.0,
        children: [
          inputRuc,
          inputCompanyName,
          inputIndustry,
          inputAddress,
          inputDepartment,
          inputDistrict,
          btnPay
        ],
      ),
    );
  }
}
