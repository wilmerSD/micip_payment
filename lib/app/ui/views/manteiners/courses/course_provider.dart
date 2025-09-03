import 'package:cip_payment_web/app/models/course_model.dart';
import 'package:cip_payment_web/app/models/modality_model.dart';
import 'package:cip_payment_web/app/models/state_model.dart';
import 'package:cip_payment_web/app/ui/components/toast/toast.dart';
import 'package:cip_payment_web/core/helpers/helpers.dart';
import 'package:cip_payment_web/services/firebase/course_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CourseProvider with ChangeNotifier {
  final courseService = CourseService();
  TextEditingController ctrlDescriptionCourse = TextEditingController();
  TextEditingController ctrlEndDateCourse = TextEditingController(
      text: Helpers.dateToStringTimeDMY(
          DateTime.now().add(const Duration(days: 15))));
  TextEditingController ctrlEndDateRegistration = TextEditingController();
  TextEditingController ctrlNameCourse = TextEditingController();
  TextEditingController ctrlPriceCourse = TextEditingController();
  TextEditingController ctrlStartDateCourse =
      TextEditingController(text: Helpers.dateToStringTimeDMY(DateTime.now()));
  TextEditingController ctrlStateCourse = TextEditingController();
  TextEditingController ctrlTotalTimeHours = TextEditingController();
  TextEditingController ctrlUpdatedDate = TextEditingController();
  TextEditingController ctrlImageCourse = TextEditingController();
  TextEditingController ctrlTypeCourse = TextEditingController();

  List<CourseModel> listCourses = [];
  List<StateModel> stateCourses = [
    StateModel(isActive: true, descripcion: 'Activo'),
    StateModel(isActive: false, descripcion: 'Desactivado'),
  ];
  List<StateModel> listItIsExternal = [
    StateModel(isActive: true, descripcion: 'Sí'),
    StateModel(isActive: false, descripcion: 'Propio'),
  ];
  StateModel currentItIsExternal =
      StateModel(isActive: true, descripcion: 'Sí');

  StateModel currentStateCourse =
      StateModel(isActive: true, descripcion: 'Activo');

  List<ModalityModel> listModality = [
    ModalityModel(id: 1, description: 'Presencial'),
    ModalityModel(id: 2, description: 'Virtual'),
    ModalityModel(id: 3, description: 'Híbrido'),
  ];
  ModalityModel currentModality =
      ModalityModel(id: 1, description: 'Presencial'); // Presencial por defecto

  Future<void> createCourse(BuildContext context) async {
    try {
      final response = await courseService.createCourse(CourseModel(
          itIsExternal: currentItIsExternal.isActive,
          createDate: Timestamp.fromDate(DateTime.now()),
          descriptionCourse: ctrlDescriptionCourse.text,
          endDateCourse: Helpers.stringToTimestamp(ctrlEndDateCourse.text),
          endDateRegistration:
              Helpers.stringToTimestamp(ctrlEndDateRegistration.text),
          imageCourse: '',
          modalityCourse: currentModality.id,
          nameCourse: ctrlNameCourse.text,
          personId: '',
          priceCourse: double.tryParse(ctrlPriceCourse.text) ?? 0.0,
          startDateCourse: Helpers.stringToTimestamp(ctrlStartDateCourse.text),
          stateCourse: currentStateCourse.isActive,
          totalTimeHours: int.tryParse(ctrlTotalTimeHours.text) ?? 0,
          updatedDate: Timestamp.fromDate(DateTime.now())));
      if (response != null && response.isNotEmpty) {
        showToastGlobal(context, 0, "success", "Mensaje de éxito");
        context.pop();
        return;
      }
    } catch (e) {
      showToastNow(1, "error", Helpers.knowTypeError(e.toString()));
    }
  }

  void cleanSearch() {}
  Future<void> getCourse() async {
    try {
      final response = await courseService.fetchAllCourse();
      if (response.isNotEmpty) {
        listCourses = response;
      }
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  bool showToast = false;
  Widget toast = Container(
    height: 20,
    width: 200,
    color: Colors.yellow,
  );
  /* 📌 Toast */
  void showToastNow(int icon, String type, String text) async {
    showToast = true;
    toast = Toast(icon: icon, typeToast: type, text: text);
    await Future.delayed(const Duration(milliseconds: 2500));
    showToast = false;
    notifyListeners();
  }

  void equalVarToEdit(CourseModel course) {
    ctrlDescriptionCourse.text = course.descriptionCourse ?? '';
    ctrlEndDateCourse.text = Helpers.timestampToString(course.endDateCourse!);
    ctrlEndDateRegistration.text =
        Helpers.timestampToString(course.endDateRegistration!);
    currentItIsExternal = StateModel(
      isActive: course.itIsExternal ?? false,
      descripcion: course.itIsExternal == true ? 'Sí' : 'Propio',
    );
    ctrlNameCourse.text = course.nameCourse ?? '';
    ctrlPriceCourse.text = course.priceCourse.toString();
    ctrlStartDateCourse.text =
        Helpers.timestampToString(course.startDateCourse!);
    ctrlStateCourse.text = course.stateCourse == true ? 'Activo' : 'Inactivo';
    ctrlTotalTimeHours.text = course.totalTimeHours.toString();
    ctrlUpdatedDate.text = Helpers.timestampToString(course.updatedDate!);
    ctrlImageCourse.text = course.imageCourse ?? '';
    // ctrlTypeCourse.text = course.typeCourse ?? '';
  }

  void cleanVars() {
    ctrlDescriptionCourse.text = '';
    ctrlEndDateCourse.text =
        Helpers.dateToStringTimeDMY(DateTime.now().add(const Duration(days: 15)));
    ctrlEndDateRegistration.text = '';
    currentItIsExternal =
        StateModel(isActive: true, descripcion: 'Sí'); // Valor por defecto
    ctrlNameCourse.text = '';
    ctrlPriceCourse.text = '';
    ctrlStartDateCourse.text =
        Helpers.dateToStringTimeDMY(DateTime.now());
    currentStateCourse =
        StateModel(isActive: true, descripcion: 'Activo'); // Valor por defecto
    ctrlTotalTimeHours.text = '';
    ctrlUpdatedDate.text = '';
    ctrlImageCourse.text = '';
    // ctrlTypeCourse.text = '';
    currentModality =
        ModalityModel(id: 1, description: 'Presencial'); // Valor por defecto
  }
}
