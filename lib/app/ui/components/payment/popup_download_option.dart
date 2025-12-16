import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/app/ui/views/certificateskill/widgets/certificate_skil_pdf.dart';
import 'package:cip_payment_web/app/ui/views/proofnodebt/widgets/proofnodebt_pdf.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/helpers/generate_receipt.dart';
import 'package:cip_payment_web/core/helpers/helpers.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/domain/entities/speciality.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

enum AnimationStyles { defaultStyle, custom, none }

enum Menu { receipt, certificate }

class PopupDownloadOption extends StatefulWidget {
  const PopupDownloadOption(
    this.receiptNumber,
    this.date,
    this.name,
    this.dni,
    this.subtotal,
    this.typePay,
    this.speciality,
    this.enabledUntil, {
    super.key,
  });

  final String receiptNumber;
  final String date;
  final String name;
  final String dni;
  final double subtotal;
  final String typePay;
  final Speciality? speciality;
  final String? enabledUntil;

  @override
  State<PopupDownloadOption> createState() => _PopupDownloadOptionState();
}

class _PopupDownloadOptionState extends State<PopupDownloadOption> {
  AnimationStyle? _animationStyle;

  @override
  Widget build(BuildContext context) {
    
    final auth = context.read<AuthProvider>().currentPerson;
    _animationStyle = const AnimationStyle(
      curve: Easing.emphasizedDecelerate,
      duration: Duration(seconds: 1),
    );
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PopupMenuButton<Menu>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color:
                    AppColors.shadowAppBarColor(context), // 👈 color del borde
                width: 2, // grosor del borde
              ),
            ),
            elevation: 0,
            offset: const Offset(0, 20), // 👈 Esto baja el menú 20px
            color: AppColors.backgroundColor(context),
            borderRadius: BorderRadius.circular(16),
            shadowColor: const Color.fromARGB(145, 158, 158, 158).withValues(),
            popUpAnimationStyle: _animationStyle,
            icon: const Icon(
              Bootstrap.download,
              color: AppColors.secondConst,
            ),
            onSelected: (Menu item) async {
              // Mostramos el loader antes de ejecutar el trabajo pesado
              await Future.delayed(Duration.zero, () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(child: CircularProgressIndicator());
                  },
                );
              });
              switch (item) {
                case Menu.receipt:
                  final double igv = widget.subtotal * 0.18;
                  await generateReceipt(
                    receiptNumber: widget.receiptNumber,
                    date: widget.date,
                    name: widget.name,
                    dni: widget.dni,
                    subtotal: widget.subtotal,
                    igv: igv,
                    total: widget.subtotal,
                    typePay: widget.typePay,
                  );
                  break;
                case Menu.certificate:
                  switch (widget.typePay) {
                    case textMonthlyfees:
                      break;
                    case textCertificateskill:
                      //TODO: llamar a la funcion que genera el certificado
                      await Future.delayed(const Duration(milliseconds: 50));
                      final file = await generateCertificateSkill(
                          name: widget.name,
                          council: 'Lambayeque',
                          cipNumber: auth?.numberCip ?? '',
                          incorporationDate:
                              Helpers.timestampToString(auth?.dataEntryPerson),
                          specialty: widget.speciality?.nameSpeciality ?? '',
                          subject: textCertificateskill,
                          owner: widget.name,
                          place: 'Lambayeque',
                          dateText: widget.date);

                      // SharePlus.instance
                      //     .share(ShareParams(files: [XFile(file.path)]));
                      break;
                    case textProofnodebt:
                      // final logo = await PdfAssets.getLogo();
                      await Future.delayed(const Duration(milliseconds: 50));
                      // final params = {
                      //   'name': widget.name,
                      //   'council': 'Lambayeque',
                      //   'specialty': widget.speciality?.nameSpeciality ?? '',
                      //   'cipNumber': auth?.numberCip ?? '',
                      //   'monthYear': widget.enabledUntil ?? '',
                      //   'dateText': widget.date,
                      // };
                      // final path = await compute(
                      //     generateNoDebtCertificateIsolate, params);
                      //     print(path);
                      //     final file = File(path);

                      // await SharePlus.instance
                      //     .share(ShareParams(files: [XFile(file.path)]));
                      final file = await generateNoDebtCertificate(
                          name: widget.name,
                          council: 'Lambayeque',
                          specialty: widget.speciality?.nameSpeciality ?? '',
                          cipNumber: auth?.numberCip ?? '',
                          monthYear: widget.enabledUntil ?? '',
                          dateText: widget.date,
                          // logo: logo,
                          );
                      SharePlus.instance
                          .share(ShareParams(files: [XFile(file.path)]));
                      break;
                    case textAdvancepayment:
                      break;
                  }
                  break;
              }
              if (context.mounted) Navigator.pop(context);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              const PopupMenuItem<Menu>(
                height: 10.0,
                value: Menu.receipt,
                child: ListTile(
                  leading: Icon(Bootstrap.receipt),
                  title: Text('Comprobante'),
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<Menu>(
                height: 10.0,
                value: Menu.certificate,
                child: ListTile(
                  leading: const Icon(Bootstrap.file_earmark_text),
                  title: Text(widget.typePay),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
