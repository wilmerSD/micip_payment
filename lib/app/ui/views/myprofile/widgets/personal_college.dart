import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/components/fields/read_only_field.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/myprofile_provider.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/widgets/data_table_college.dart';
import 'package:cip_payment_web/core/helpers/responsive.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalCollege extends StatelessWidget {
  const PersonalCollege({super.key});

  @override
  Widget build(BuildContext context) {
    final recoverpassController = Provider.of<MyprofileProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final person = authProvider.currentPerson;

    /* 📌 Input cip del colegiado */
    Widget inputCollege = ReadOnlyField(
      label: 'Numero Cip',
      value: person?.numberCip ?? '',
    );

    /* 📌 Input fecha de ingreso al colegio de ingenieros */
    Widget inputEntryDate = ReadOnlyField(
      label: 'Fecha de ingreso',
      value: '23/07/2020', //person?.numberCip ?? '',
    );

    /* 📌 Input catidad de años del colegiado*/
    Widget inputQuantityAges = ReadOnlyField(
      label: 'Años de colegiado',
      value: authProvider.yearsOfMembership.toString(),
    );

    /* 📌 btn para cambiar la contraseña */
    Widget btnChangePass = BtnPrimaryInk(
      text: recoverpassController.isLoading
          ? "Cambiando..."
          : "Cambiar contraseña",
      loading: recoverpassController.isLoading,
      onTap: () => {},
    );

    Widget content = Padding(
      padding: const EdgeInsets.all(15),
      child: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 25.0),
            inputCollege,
            const SizedBox(height: 25.0),
            inputEntryDate,
            const SizedBox(height: 25.0),
            inputQuantityAges,
            const SizedBox(height: 25.0),
            SizedBox(
              height: 160,
              // color: Colors.amber,
              child: const ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: DataTableCollege(),
              ),
            ),
            // Spacer(),
          ],
        ),
      ),
    );

    return Responsive.isMobile(context)
        ? Scaffold(backgroundColor: AppColors.backgroundColor(context), body: content)
        : content;
  }
}
