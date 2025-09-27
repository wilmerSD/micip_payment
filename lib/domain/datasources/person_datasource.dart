import 'package:cip_payment_web/domain/entities/person.dart';
import 'package:cip_payment_web/infrastructure/models/person_model.dart';

abstract class PersonDatasource {
  Future<List<Person>> fetchAllPersons();
  Future<Person?> getPersonById(String personId);
  Future<Person?> createPerson(PersonModel person);
}
