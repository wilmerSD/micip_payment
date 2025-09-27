import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  final String id;
  final String address;
  final String civilStatus;
  final Timestamp dataEntryPerson;
  final Timestamp dateBirth;
  final String dni;
  final String emailMain;
  final String emailSecondary;
  final String genderPerson;
  final String imagePerson;
  final String motherSurname;
  final String nacionality;
  final String namePerson;
  final String numberCip;
  final String numberPhone;
  final String paternalSurname;
  final String personId;
  final String ruc;
  final String? specialityId;
  final bool? stateCollegiate;
  final bool statePerson;
  final String? typePersonId;
  final bool? isAdmin;

  Person({
    required this.id,
    required this.address,
    required this.civilStatus,
    required this.dataEntryPerson,
    required this.dateBirth,
    required this.dni,
    required this.emailMain,
    required this.emailSecondary,
    required this.genderPerson,
    required this.imagePerson,
    required this.motherSurname,
    required this.nacionality,
    required this.namePerson,
    required this.numberCip,
    required this.numberPhone,
    required this.paternalSurname,
    required this.personId,
    required this.ruc,
    this.specialityId,
    this.stateCollegiate,
    required this.statePerson,
    this.typePersonId,
    this.isAdmin
  });
  
}
