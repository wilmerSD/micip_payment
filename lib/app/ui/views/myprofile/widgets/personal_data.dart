import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/app/ui/components/display_text.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/widgets/custom_tittle_appbar.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/widgets/leading.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalData extends StatelessWidget {
  const PersonalData({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final person = authProvider.currentPerson;

    /* 📌 Input de colegiado */
    Widget inputCollege = DisplayText(
      helperText: 'Colegiado',
      text: person?.namePerson ?? '',
    );

    /* 📌 Input de dni */
    Widget inputDni = DisplayText(
      helperText: 'DNI',
      text: person?.dni ?? '',
    );

    /* 📌 Input de dni */
    Widget inputAge = DisplayText(
      helperText: 'Edad',
      text: authProvider.age.toString(),
    );

    /* 📌 Input de dni */
    Widget inputGender = DisplayText(
      helperText: 'Género',
      text: person?.genderPerson == 'M' ? 'Masculino' : 'Femenino',
    );

    Widget inputCivilState = DisplayText(
      helperText: 'Estado civil',
     text: person?.civilStatus ?? ''
    );

    Widget inputBirthDate = DisplayText(
      helperText: 'Fecha de nacimiento',
      text: authProvider.birthDateFormatted,
    );

    return Scaffold(
        backgroundColor: AppColors.backgroundColor(context),
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor(context),
          surfaceTintColor: Colors.transparent,
          leading: const Leading(),
          title: const CustomTittleAppbar(tittle: 'Datos personales'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              const SizedBox(
                height: 25.0,
              ),
              inputCollege,
              const SizedBox(
                height: 25.0,
              ),
              inputDni,
              const SizedBox(
                height: 25.0,
              ),
              inputAge,
              const SizedBox(
                height: 25.0,
              ),
              inputGender,
              const SizedBox(
                height: 25.0,
              ),
              inputCivilState,
              const SizedBox(
                height: 25.0,
              ),
              inputBirthDate,
              const SizedBox(
                height: 25.0,
              ),
            ],
          ),
        ));
  }
}
