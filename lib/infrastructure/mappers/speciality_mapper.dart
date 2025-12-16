import 'package:cip_payment_web/domain/entities/speciality.dart';
import 'package:cip_payment_web/infrastructure/models/speciality_model.dart';

class SpecialityMapper {
  static Speciality specialityResponseToEntity(SpecialityModel speciality) =>
      Speciality(
        descriptionSpeciality: speciality.descriptionSpeciality ?? '',
        id: speciality.id ?? '',
        nameSpeciality: speciality.nameSpeciality ?? '',
        stateSpeciality: speciality.stateSpeciality ?? false,
      );
}
