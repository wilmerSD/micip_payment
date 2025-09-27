import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/app/ui/components/fields/display_text.dart';
import 'package:cip_payment_web/app/ui/components/fields/read_only_field.dart';
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
    Widget inputCollege = ReadOnlyField(
      label: 'Colegiado',
      value: person?.namePerson ?? '',
    );

    /* 📌 Input de dni */
    Widget inputDni = ReadOnlyField(label: 'DNI', value: person?.dni ?? '');

    /* 📌 Input de dni */
    Widget inputAge = ReadOnlyField(
      label: 'Edad',
      value: authProvider.age.toString(),
    );

    /* 📌 Input de dni */
    Widget inputGender = ReadOnlyField(
      label: 'Género',
      value: person?.genderPerson == 'M' ? 'Masculino' : 'Femenino',
    );

    Widget inputCivilState = ReadOnlyField(
      label: 'Estado civil',
      value: person?.civilStatus ?? '',
    );

    Widget inputBirthDate = ReadOnlyField(
      label: 'Fecha de nacimiento',
      value: authProvider.birthDateFormatted,
    );

    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
        children: [
          const SizedBox(height: 25.0),
          inputCollege,
          const SizedBox(height: 25.0),
          inputDni,
          const SizedBox(height: 25.0),
          inputAge,
          const SizedBox(height: 25.0),
          inputGender,
          const SizedBox(height: 25.0),
          inputCivilState,
          const SizedBox(height: 25.0),
          inputBirthDate,
          const SizedBox(height: 25.0),
        ],
      ),
    );
  }
}
