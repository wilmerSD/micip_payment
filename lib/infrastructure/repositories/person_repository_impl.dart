import 'package:cip_payment_web/domain/datasources/person_datasource.dart';
import 'package:cip_payment_web/domain/entities/person.dart';
import 'package:cip_payment_web/domain/repositories/person_repository.dart';
import 'package:cip_payment_web/infrastructure/models/person_model.dart';

class PersonRepositoryImpl extends PersonRepository {
  final PersonDatasource datasource;

  PersonRepositoryImpl(this.datasource);

  @override
  Future<Person?> createPerson(PersonModel person) {
    return datasource.createPerson(person);
  }

  @override
  Future<List<Person>> fetchAllPersons(
    String mainEmail,
    String dni,
    String names,
  ) {
    return datasource.fetchAllPersons(mainEmail, dni, names);
  }

  @override
  Future<Person?> getPersonById(String personId) {
    return datasource.getPersonById(personId);
  }
  
  Future<void> pruebaBuscarEspecialidadPerson(String personId){
    return datasource.pruebaBuscarEspecialidadPerson(personId);
  }
}
