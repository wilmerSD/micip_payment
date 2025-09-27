import 'package:cip_payment_web/domain/entities/course.dart';
import 'package:cip_payment_web/infrastructure/models/course_model.dart';

class CourseMapper {
  static Course courseResponseToEntity(CourseModel coursedb) =>
  Course(
    itIsExternal: coursedb.itIsExternal ?? false,
    createDate: coursedb.createDate,
    descriptionCourse: coursedb.descriptionCourse ?? '',
    endDateCourse: coursedb.endDateCourse,
    endDateRegistration: coursedb.endDateRegistration,
    imageCourse: coursedb.imageCourse ?? '',
    modalityCourse: coursedb.modalityCourse,
    nameCourse: coursedb.nameCourse,
    personId: coursedb.personId,
    priceCourse: coursedb.priceCourse,
    startDateCourse: coursedb.startDateCourse,
    stateCourse: coursedb.stateCourse ?? false,
    totalTimeHours: coursedb.totalTimeHours ?? 0,
    updatedDate: coursedb.updatedDate,
  );
}