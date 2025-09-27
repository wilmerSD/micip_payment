import 'package:cip_payment_web/domain/entities/course.dart';
import 'package:cip_payment_web/infrastructure/models/course_model.dart';

abstract class CourseDatasource {
  Future<List<Course>> fetchAllCourse();
  Future<Course?> createCourse(CourseModel course);
}
