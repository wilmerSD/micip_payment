import 'package:cip_payment_web/domain/entities/speciality.dart';

abstract class SpecialityRepository {
  Future<List<Speciality>> getSpecialties(String personId);
  // Future<Speciality?> createSpeciality(); 
  // Future<Speciality?> deleteSpeciality();
  // Future<Speciality?> updateSpeciality();
}
