import 'package:cip_payment_web/app/providers/bill_provider.dart';
import 'package:cip_payment_web/app/ui/components/bill/company_form.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_rounded.dart';
import 'package:cip_payment_web/app/ui/components/modal_new_note.dart';
import 'package:cip_payment_web/app/ui/views/advancepayment/advancepayment_provider.dart';
import 'package:cip_payment_web/app/ui/views/certificateskill/certificateskill_provider.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/monthlyfees_provider.dart';
import 'package:cip_payment_web/app/ui/views/proofnodebt/proofnodebt_provider.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:cip_payment_web/domain/entities/enums.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class FieldsBill extends StatelessWidget {
  const FieldsBill({
    super.key,
    required this.textBtn,
    required this.textPopUp,
    required this.content,
    required this.onTap,
  });
  final void Function() onTap;
  final String textBtn;
  final String textPopUp;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    print('Raiz field bill');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final companies = context.read<BillProvider>().listCompanies;
      if (companies.isNotEmpty) {
        final firstCompany = companies.first;
        // Asignar al MonthlyfeesProvider
        context.read<MonthlyfeesProvider>().rucId = firstCompany.id ?? '';
        context.read<CertificateSkillProvider>().rucId = firstCompany.id ?? '';
        context.read<ProofnodebtProvider>().rucId = firstCompany.id ?? '';
        context.read<AdvancepaymentProvider>().rucId = firstCompany.id ?? '';
        
        // Seleccionar en el billProvider
        context.read<BillProvider>().selectCompany(firstCompany.id ?? '');
      }
    });
    return Builder(
      builder: (context){
        print('raiz fields bill 3');
        return SafeArea(child: _payView(context, textBtn, onTap));
      }
    );
  }
}

Widget _payView(
    BuildContext context, String textBtn, final void Function() onTap) {
  final billProvider = Provider.of<BillProvider>(context);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Column(
      children: [
        Row(
          children: [
            const Expanded(child: SizedBox()),
            BtnRounded(null, 'Registrar nuevo ruc', () {
              // Navigator.pop(context);
              context.read<BillProvider>().onCreate();
              ModalUtils.getShowModalBS(
                context,
                content: ChangeNotifierProvider.value(
                  value: context.read<BillProvider>(),
                  child: const CompanyForm('Registrar', true, true),
                ),
                title: 'Crear nueva factura',
              );
            }),
          ],
        ),
        const SizedBox(
          height: 15.0,
        ),
        SizedBox(
          height: 350.0,
          child: SingleChildScrollView(
              child: Wrap(
            spacing: 30.0,
            runSpacing: 10.0,
            children: List.generate(billProvider.listCompanies.length,
                /* context.read<BillProvider>().listCompanies.length, */ (
              index,
            ) {
              final company = context.read<BillProvider>().listCompanies[index];
              return _customContainer(
                context,
                company.businessName ?? '',
                () {
                  context.read<MonthlyfeesProvider>().rucId = company.id ?? '';
                  context.read<CertificateSkillProvider>().rucId =  company.id ?? '';
                  context.read<ProofnodebtProvider>().rucId =  company.id ?? '';
                  context.read<AdvancepaymentProvider>().rucId = company.id ?? '';
                  billProvider.selectCompany(company.id ?? ''); // 👈 selecciona
                },
                company.ruc ?? '',
                company.address ?? '',
                () {
                  print('tratando de elimnar');
                  context
                      .read<BillProvider>()
                      .deleteRuc(context, company.id ?? '');
                },
                () {
                  context.read<BillProvider>().onEdit(company.id ?? '');
                  ModalUtils.getShowModalBS(
                    context,
                    content: ChangeNotifierProvider.value(
                      value: context.read<BillProvider>(),
                      child: const CompanyForm('Guardar', false, true),
                    ),
                    title: 'Editar factura',
                  );
                },
                billProvider.selectedCompanyId ==
                    company.id, // 👈 verifica si está seleccionado
              );
            }),
          )),
        ),
        const SizedBox(
          height: 10.0,
        ),
        BtnPrimaryInk(
          text: textBtn, 
          onTap:(){
            print('Seleccionado RUC ID: ${context.read<MonthlyfeesProvider>().rucId}');
            context.read<MonthlyfeesProvider>().receiptType = ReceiptType.invoice.code;
            context.read<CertificateSkillProvider>().receiptType  = ReceiptType.invoice.code;
            context.read<ProofnodebtProvider>().receiptType  = ReceiptType.invoice.code;
            context.read<AdvancepaymentProvider>().receiptType  = ReceiptType.invoice.code;
            onTap();
          } ),
        const SizedBox(),
      ],
    ),
  );
}

Widget _customContainer(
    BuildContext context,
    String text,
    VoidCallback ontap,
    String textSecond,
    textThird,
    VoidCallback onDelete,
    VoidCallback onEdit,
    bool isSelected) {
  return InkWell(
    onTap: ontap,
    borderRadius: BorderRadius.circular(10.0),
    child: Container(
      // height: 70.0,
      padding: const EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color.fromARGB(92, 249, 249, 250),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryConst
                : const Color.fromRGBO(232, 242, 250, 1),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: AppTextStyle(context).bold16(
                    // fontWeight: FontWeight.w500,
                    color: AppColors.textBasic(context)),
              ),
            ],
          ),
          Text(textSecond),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text(textThird, overflow:TextOverflow.ellipsis )),
              Container(
                // color: Colors.amber,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: onEdit,
                        icon: const Icon(
                          Iconsax.edit_outline,
                          size: 20.0,
                        )),
                    IconButton(
                      icon: const Icon(
                        Iconsax.trash_outline,
                        color: Colors.red,
                        size: 20.0,
                      ),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
