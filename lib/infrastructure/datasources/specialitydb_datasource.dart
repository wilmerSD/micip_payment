import 'package:cip_payment_web/domain/datasources/speciality_datasource.dart';
import 'package:cip_payment_web/domain/entities/speciality.dart';
import 'package:cip_payment_web/infrastructure/mappers/speciality_mapper.dart';
import 'package:cip_payment_web/infrastructure/models/speciality_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SpecialitydbDatasource extends SpecialityDatasource {
  final FirebaseFirestore firestoredb = FirebaseFirestore.instance;

  @override
  Future<List<Speciality>> getSpecialties([String? personId]) async {
    try {
      if (personId == null || personId.isEmpty) {
        // Obtener TODAS las especialidades
        final response = await firestoredb.collection('Speciality').get();

        final specialties = response.docs
            .map(
              (doc) => SpecialityMapper.specialityResponseToEntity(
                SpecialityModel.fromJson(doc.data()),
              ),
            )
            .toList();

        return specialties;
      }

      // Si sí viene el personId → traer solo las asociadas
      final response = await firestoredb
          .collection('PersonSpeciality')
          .where("personId", isEqualTo: personId)
          .get();

      final specialityIds = response.docs
          .map((doc) => doc['specialityId'] as String)
          .toList();

      if (specialityIds.isEmpty) return [];

      final specialtiesResponse = await firestoredb
          .collection('Speciality')
          .where(FieldPath.documentId, whereIn: specialityIds)
          .get();

      final specialties = specialtiesResponse.docs
          .map(
            (doc) => SpecialityMapper.specialityResponseToEntity(
              SpecialityModel.fromJson(doc.data()),
            ),
          )
          .toList();

      return specialties;
    } catch (e) {
      print("Error obteniendo especialidades: $e");
      return [];
    }
  }
}
