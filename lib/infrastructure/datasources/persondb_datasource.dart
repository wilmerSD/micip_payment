import 'package:cip_payment_web/domain/datasources/person_datasource.dart';
import 'package:cip_payment_web/domain/entities/person.dart';
import 'package:cip_payment_web/infrastructure/mappers/person_mapper.dart';
import 'package:cip_payment_web/infrastructure/models/person_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PersondbDatasource extends PersonDatasource {
  final FirebaseFirestore firestoredb = FirebaseFirestore.instance;

  @override
  Future<List<Person>> fetchAllPersons() async {
    try {
      final snapshot = await firestoredb.collection('Person').get();

      final data = snapshot.docs.map((doc) {
        final data = doc.data();
        final id = doc.id;
        return PersonModel.fromFirestore(id, data);
      }).toList();
      final persons = data
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

        // 3. Mapear a Response
        final personResponse = PersonModel.fromFirestore(response.id, data);

        // 4. Mapear a Entidad
        final newPerson = PersonMapper.personResponseToEntity(personResponse);
        return newPerson;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
