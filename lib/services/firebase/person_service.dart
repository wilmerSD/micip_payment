import 'package:cip_payment_web/app/models/person_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonService {
  final FirebaseFirestore firestoredb = FirebaseFirestore.instance;

  Future<List<PersonModel>> fetchAllPersons() async {
    try {
      final snapshot = await firestoredb.collection('Person').get();

      final persons = snapshot.docs.map((doc) {
        final data = doc.data();
        final id = doc.id;
        return PersonModel.fromFirestore(id, data);
      }).toList();

      return persons;
    } catch (e) {
      print('Error al obtener personas: $e');
      return [];
    }
  }

  Future<PersonModel?> getPersonById(String personId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('Person')
          .doc(personId)
          .get();

      if (doc.exists) {
        return PersonModel.fromFirestore(doc.id, doc.data()!);
      } else {
        return null;
      }
    } catch (e) {
      print('❌ Error al obtener persona: $e');
      return null;
    }
  }

  Future<String> createPerson(PersonModel person) async {
    try {
      final response = await FirebaseFirestore.instance
          .collection('Person')
          .add(person.toFirestore());
      print('✅ Persona creada exitosamente');
      if (response.id.isNotEmpty) {
        return response.id;
      }
      return '';
    } catch (e) {
      return '';
    }
  }
}
