import 'package:cip_payment_web/app/ui/components/button/btn_secondary.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_third.dart';
import 'package:cip_payment_web/app/ui/components/fields/custom_text_field.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/person/person_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FormPerson extends StatelessWidget {
const FormPerson({ 
  super.key,
  required this.personProvider
 });

 final PersonProvider personProvider;

  @override
  Widget build(BuildContext context){
    return Container(
    width: 800.0,
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
    child: Column(
      spacing: 15,
      children: [
        Row(
          spacing: 30.0,
          children: [
            Expanded(
              child: CustomTextField(
                helperText: 'Nombre',
                textEditingController:
                    personProvider.namePerson, // context.read<PersonProvider>,
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            Expanded(
              child: CustomTextField(
                helperText: 'Género',
                textEditingController: personProvider
                    .genderPerson, // context.read<PersonProvider>,
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ],
        ),
        Row(
          spacing: 30.0,
          children: [
            Expanded(
              child: CustomTextField(
                helperText: 'Apellido paterno',
                textEditingController: personProvider
                    .paternalSurname, // context.read<PersonProvider>,
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            Expanded(
              child: CustomTextField(
                helperText: 'Apellido materno',
                textEditingController: personProvider
                    .motherSurname, // context.read<PersonProvider>,
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ],
        ),
        Row(
          spacing: 30.0,
          children: [
            Expanded(
              child: CustomTextField(
                helperText: 'DNI',
                textEditingController:
                    personProvider.dni, // context.read<PersonProvider>,
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            Expanded(
              child: CustomTextField(
                helperText: 'Ruc',
                textEditingController:
                    personProvider.ruc, // context.read<PersonProvider>,
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ],
        ),
        Row(
          spacing: 30.0,
          children: [
            Expanded(
              child: CustomTextField(
                helperText: 'Fecha de nacimiento',
                textEditingController:
                    personProvider.dateBirth, // context.read<PersonProvider>,
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            Expanded(
              child: CustomTextField(
                helperText: 'Estado civil',
                textEditingController:
                    personProvider.civilStatus, // context.read<PersonProvider>,
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ],
        ),
        Row(
          spacing: 30.0,
          children: [
            Expanded(
              child: CustomTextField(
                helperText: 'Email principal',
                textEditingController:
                    personProvider.emailMain, // context.read<PersonProvider>,
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            Expanded(
              child: CustomTextField(
                helperText: 'Email secundario',
                textEditingController: personProvider
                    .emailSecondary, // context.read<PersonProvider>,
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ],
        ),
        Row(
          spacing: 30.0,
          children: [
            Expanded(
              child: CustomTextField(
                helperText: 'Dirección',
                textEditingController:
                    personProvider.address, // context.read<PersonProvider>,
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            Expanded(
              child: CustomTextField(
                helperText: 'Especialidad',
                textEditingController: personProvider
                    .specialityId, // context.read<PersonProvider>,
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ],
        ),
        const SizedBox(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 20.0,
          children: [
            SizedBox(
                width: 150,
                child:
                    BtnSecondary(text: 'Cancelar', onTap: () => context.pop())),
            SizedBox(
                height: 45.0,
                width: 150.0,
                child: BtnThird(
                  text: 'Guardar',
                  onTap: () => personProvider.newPerson(context),
                )),
          ],
        )
      ],
    ),
  );
  }
}