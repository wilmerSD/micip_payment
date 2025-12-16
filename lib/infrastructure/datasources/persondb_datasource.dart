import 'package:cip_payment_web/domain/datasources/person_datasource.dart';
import 'package:cip_payment_web/domain/entities/person.dart';
import 'package:cip_payment_web/domain/entities/user.dart';
import 'package:cip_payment_web/infrastructure/mappers/person_mapper.dart';
import 'package:cip_payment_web/infrastructure/models/person_model.dart';
import 'package:cip_payment_web/infrastructure/models/personspeciality_model.dart';
import 'package:cip_payment_web/infrastructure/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PersondbDatasource extends PersonDatasource {
  final FirebaseFirestore firestoredb = FirebaseFirestore.instance;

  @override
  Future<List<Person>> fetchAllPersons(String mainEmail, String dni, String names) async {
    try {
      // mainEmail = "usuario36@gmail.com";
      // Empezamos con la colección base
    Query query = firestoredb.collection('Person');

    // Agregamos filtros solo si los valores no están vacíos o nulos
    if (mainEmail != null && mainEmail.isNotEmpty) {
      query = query.where("emailMain", isEqualTo: mainEmail);
    }
    if (dni != null && dni.isNotEmpty) {
      query = query.where("dni", isEqualTo: dni);
    }
    if (names != null && names.isNotEmpty) {
      query = query.where("namePerson", isEqualTo: names);
    }
    // Ejecutamos la consulta final
    final snapshot = await query.get();
      final dataSnapShot = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final id = doc.id;
        return PersonModel.fromFirestore(id, data);
      }).toList();
      print(snapshot.docs);
      final persons = dataSnapShot
          .map((resp) => PersonMapper.personResponseToEntity(resp))
          .toList();
      return persons;
    } catch (e) {
      debugPrint('Error al obtener personas: $e');
      return [];
    }
  }

  @override
  Future<Person?> getPersonById(String personId) async {
    try {
      final doc = await firestoredb.collection('Person').doc(personId).get();

      if (doc.exists) {
        final data = PersonModel.fromFirestore(doc.id, doc.data()!);
        final person = PersonMapper.personResponseToEntity(data);
        return person;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('❌ Error al obtener persona: $e');
      return null;
    }
  }

  @override
  Future<Person?> createPerson(PersonModel person) async {
    try {
      final response = await firestoredb
          .collection('Person')
          .add(person.toFirestore());

      debugPrint('✅ Persona creada exitosamente');
      if (response.id.isNotEmpty) {
        // 2. Obtener datos recién guardados
        final snapshot = await response.get();
        final data = snapshot.data() as Map<String, dynamic>;
        // 2. Actualizar el documento para incluir el id generado
        await response.update({'personId': response.id});
        // 3. Mapear a Response
        final personResponse = PersonModel.fromFirestore(response.id, data);

        // 4. Mapear a Entidad
        final newPerson = PersonMapper.personResponseToEntity(personResponse);
        final user = UserModel(
          password: newPerson.dni,
          personId:  response.id,
          stateUser: true,
          userName: newPerson.emailMain,
        );
        final personSpeciality = PersonspecialityModel(
          personId:  response.id,
          specialityId: person.specialityId,
        );
        await firestoredb.collection('PersonSpeciality').add(personSpeciality.toJson());
        await firestoredb.collection('User').add(user.toJson());

        return newPerson;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> pruebaBuscarEspecialidadPerson(String personId) async {
    try {
      final response = await firestoredb
          .collection('PersonSpeciality')
          .where("personId", isEqualTo: personId).get();
      print('Sí se encontro: '+response.docs.toString());
    } catch (e) {
      return null;
    }
  }


}
