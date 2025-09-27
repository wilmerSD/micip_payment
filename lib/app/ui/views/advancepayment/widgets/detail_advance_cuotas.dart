import 'package:cip_payment_web/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/components/fields/custom_text_field.dart';
import 'package:cip_payment_web/app/ui/views/advancepayment/advancepayment_provider.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/widgets/checkout_monthlyfees.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailAdvanceCuotas extends StatelessWidget {
const DetailAdvanceCuotas({ super.key });
  
  @override
  Widget build(BuildContext context){
    final advancepayment = Provider.of<AdvancepaymentProvider>(context);
    
    Widget subTotal= CustomTextField(
      enabledfield: true,
      helperText: 'Sub total',
      textInputType: TextInputType.emailAddress,
      textEditingController: advancepayment.ctrlSubTotal,
    );

    Widget discount = CustomTextField(
      enabledfield: true,
      helperText: "Descuento",
      textInputType: TextInputType.emailAddress,
      textEditingController: advancepayment.ctrlDiscount,
    );

    Widget total = CustomTextField(
      enabledfield: true,
      helperText: "Total",
      textInputType: TextInputType.emailAddress,
      textEditingController: advancepayment.ctrlTotal,
    );
    
    Widget btnPay = BtnPrimaryInk(
        text: 'Pagar S/ 240.0',
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return PopupGeneral(
                onTapButton: () => {},
                title: "Cuota mensual",
                content: const CheckoutMonthlyfees(),
              );
            },
          );  
        });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        spacing: 15,
        children: [
          subTotal,
          discount,
          total,
          btnPay,
          const SizedBox(),
        ],
      ),
    );
  }
}