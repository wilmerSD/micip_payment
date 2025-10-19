import 'package:cip_payment_web/domain/entities/person.dart';
import 'package:cip_payment_web/infrastructure/models/person_model.dart';

class PersonMapper {
  static Person personResponseToEntity(PersonModel persondb) => Person(
    id: persondb.id,
    address: persondb.address,
    civilStatus: persondb.civilStatus,
    dataEntryPerson: persondb.dataEntryPerson,
    dateBirth: persondb.dateBirth,
    dni: persondb.dni,
    emailMain: persondb.emailMain,
    emailSecondary: persondb.emailSecondary,
    genderPerson: persondb.genderPerson,
    imagePerson: persondb.imagePerson,
    motherSurname: persondb.motherSurname,
    nacionality: persondb.nacionality,
    namePerson: persondb.namePerson,
    numberCip: persondb.numberCip,
    numberPhone: persondb.numberPhone,
    paternalSurname: persondb.paternalSurname,
    personId: persondb.personId,
    ruc: persondb.ruc,
    statePerson: persondb.statePerson,
    isAdmin: persondb.isAdmin
  );
}
