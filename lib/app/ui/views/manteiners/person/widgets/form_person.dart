import 'package:cip_payment_web/app/ui/components/button/btn_secondary.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_third.dart';
import 'package:cip_payment_web/app/ui/components/dropdown/dropdown_select.dart';
import 'package:cip_payment_web/app/ui/components/dropdown/option_select.dart';
import 'package:cip_payment_web/app/ui/components/fields/custom_text_field.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/person/person_provider.dart';
import 'package:cip_payment_web/domain/entities/speciality.dart';
import 'package:cip_payment_web/infrastructure/models/select_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FormPerson extends StatelessWidget {
  const FormPerson({super.key, required this.personProvider, });
  
  final PersonProvider personProvider;
  
  Widget selectGender(BuildContext context) {
    final personProvider = Provider.of<PersonProvider>(context);
    return Select(
      isActive: false,
      label: "Especialidad",
      value: personProvider.listGender.isEmpty
          ? null
          : personProvider.listGender.firstWhere(
              (element) => element.id == personProvider.currentGender.id,
              orElse: () => personProvider.listGender.first,
            ),
      items: personProvider.listGender.map((element) {
        return DropdownMenuItem(
          value: element,
          child: OptionSelect(nameOption: element.value),
        );
      }).toList(),
      onChanged: (newValue) {
        if (newValue != null) {
          personProvider.currentGender = newValue as SelectModel;
        }
      },
    );
  }

  Widget inputSpecialtyCertificate(BuildContext context) {
    final personProvider = Provider.of<PersonProvider>(context);
    return Select(
      isActive: false,
      label: "Especialidad",
      value: personProvider.listSpecialities.isEmpty
          ? null
          : personProvider.listSpecialities.firstWhere(
              (element) => element.id == personProvider.currectSpecialty.id,
              orElse: () => personProvider.listSpecialities.first,
            ),
      items: personProvider.listSpecialities.map((element) {
        return DropdownMenuItem(
          value: element,
          child: OptionSelect(
            nameOption: element.nameSpeciality ?? '',
          ), // 👈 mostrar el nombre
        );
      }).toList(),
      onChanged: (newValue) {
        if (newValue != null) {
          personProvider.currectSpecialty = SelectModel(
            id: (newValue as Speciality).id ?? '',
            value: newValue.nameSpeciality ?? '',
          );
        }
      },
    );
  }

  Widget selectCivilState(BuildContext context) {
    final personProvider = Provider.of<PersonProvider>(context);
    return Select(
      isActive: false,
      label: "Estado civil",
      value: personProvider.listCivilState.isEmpty
          ? null
          : personProvider.listCivilState.firstWhere(
              (element) => element.id == personProvider.currentCivilState.id,
              orElse: () => personProvider.listCivilState.first,
            ),
      items: personProvider.listCivilState.map((element) {
        return DropdownMenuItem(
          value: element,
          child: OptionSelect(nameOption: element.value),
        );
      }).toList(),
      onChanged: (newValue) {
        if (newValue != null) {
          personProvider.currentCivilState = newValue as SelectModel;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800.0,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Column(
        spacing: 15,
        children: [
          Row(
            spacing: 30.0,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: CustomTextField(
                  helperText: 'Nombre',
                  textEditingController: personProvider
                      .namePerson, // context.read<PersonProvider>,
                  inputFormats: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z\sáéíóúÁÉÍÓÚñÑ]'),
                    ),
                  ],
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              Expanded(child: selectGender(context)),
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
                  inputFormats: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z\sáéíóúÁÉÍÓÚñÑ]'),
                    ),
                  ],
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
                  inputFormats: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z\sáéíóúÁÉÍÓÚñÑ]'),
                    ),
                  ],
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
                  maxLength: 8,
                  textEditingController:
                      personProvider.dni, // context.read<PersonProvider>,
                  inputFormats: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              Expanded(
                child: CustomTextField(
                  helperText: 'Ruc',
                  maxLength: 11,
                  textEditingController:
                      personProvider.ruc, // context.read<PersonProvider>,
                  inputFormats: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
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
                child: selectCivilState(context)
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
            crossAxisAlignment: CrossAxisAlignment.end,
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
              Expanded(child: inputSpecialtyCertificate(context)),
            ],
          ),

          Row(
            spacing: 30.0,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: CustomTextField(
                  helperText: 'Cip',
                  textEditingController:
                      personProvider.numberCip, // context.read<PersonProvider>,
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              Expanded(
                child: CustomTextField(
                  helperText: 'PersonId',
                  textEditingController:
                      personProvider.personIdToEdit, // context.read<PersonProvider>,
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              // Expanded(child: inputSpecialtyCertificate(context)),
            ],
          ),

          const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 20.0,
            children: [
              SizedBox(
                width: 150,
                child: BtnSecondary(
                  text: 'Cancelar',
                  onTap: () => context.pop(),
                ),
              ),
              SizedBox(
                height: 45.0,
                width: 150.0,
                child: BtnThird(
                  text: 'Guardar',
                  onTap: () => personProvider.newPerson(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
