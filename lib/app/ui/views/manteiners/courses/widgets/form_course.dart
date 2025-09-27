// import 'package:cip_payment_app/app/ui/components/custom_dropdown_menu.dart';
import 'package:cip_payment_web/infrastructure/models/modality_model.dart';
import 'package:cip_payment_web/infrastructure/models/state_model.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_secondary.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_third.dart';
import 'package:cip_payment_web/app/ui/components/fields/custom_text_field.dart';
import 'package:cip_payment_web/app/ui/components/dropdown/dropdown_select.dart';
import 'package:cip_payment_web/app/ui/components/dropdown/option_select.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/courses/course_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FormCourse extends StatelessWidget {
  const FormCourse({super.key, required this.courseProvider});

  final CourseProvider courseProvider;

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
            children: [
              Expanded(
                child: CustomTextField(
                  helperText: 'Nombre',
                  textEditingController: courseProvider
                      .ctrlNameCourse, // context.read<courseProvider>,
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              Expanded(
                child: CustomTextField(
                  helperText: 'Descripción',
                  textEditingController: courseProvider
                      .ctrlDescriptionCourse, // context.read<courseProvider>,
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
                child: Select(
                  isActive: false,
                  label: "Externo",
                  value: courseProvider.listItIsExternal.firstWhere((element) =>
                      element.isActive ==
                      courseProvider.currentItIsExternal.isActive),
                  items: courseProvider.listItIsExternal.map((element) {
                    return DropdownMenuItem(
                      value: element,
                      child: OptionSelect(nameOption: element.descripcion),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    courseProvider.currentStateCourse = newValue as StateModel;
                  },
                ),
              ),
              Expanded(
                child: CustomTextField(
                  helperText: 'Fecha de finalización',
                  textEditingController: courseProvider
                      .ctrlEndDateCourse, // context.read<courseProvider>,
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
                  helperText: 'Fecha de fin de registro',
                  textEditingController: courseProvider
                      .ctrlEndDateRegistration, // context.read<courseProvider>,
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              Expanded(
                child: CustomTextField(
                  helperText: 'Imagen',
                  textEditingController: courseProvider
                      .ctrlImageCourse, // context.read<courseProvider>,
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
                child: Select(
                  isActive: false,
                  label: "Modalidad",
                  value: courseProvider.listModality.firstWhere((element) =>
                      element.id == courseProvider.currentModality.id),
                  items: courseProvider.listModality.map((element) {
                    return DropdownMenuItem(
                      value: element,
                      child: OptionSelect(nameOption: element.description),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    courseProvider.currentModality = newValue as ModalityModel;
                  },
                ),
              ),
              Expanded(
                child: CustomTextField(
                  helperText: 'Precio',
                  textEditingController: courseProvider
                      .ctrlPriceCourse, // context.read<courseProvider>,
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
                  helperText: 'Fecha de inicio',
                  textEditingController: courseProvider
                      .ctrlStartDateCourse, // context.read<courseProvider>,
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              Expanded(
                child: Select(
                  isActive: false,
                  label: "Estado",
                  value: courseProvider.stateCourses.firstWhere((element) =>
                      element.isActive ==
                      courseProvider.currentStateCourse.isActive),
                  items: courseProvider.stateCourses.map((element) {
                    return DropdownMenuItem(
                      value: element,
                      child: OptionSelect(nameOption: element.descripcion),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    courseProvider.currentStateCourse = newValue as StateModel;
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
                  helperText: 'Total de horas',
                  textEditingController: courseProvider
                      .ctrlTotalTimeHours, // context.read<courseProvider>,
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              Expanded(
                child: CustomTextField(
                  helperText: 'Tipo',
                  textEditingController: courseProvider
                      .ctrlTypeCourse, // context.read<courseProvider>,
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
                  child: BtnSecondary(
                      text: 'Cancelar', onTap: () => context.pop())),
              SizedBox(
                  height: 45.0,
                  width: 150.0,
                  child: BtnThird(
                    text: 'Guardar',
                    onTap: () => courseProvider.createCourse(context),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
