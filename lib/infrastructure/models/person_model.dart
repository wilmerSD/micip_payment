import 'package:cloud_firestore/cloud_firestore.dart';

class PersonModel {
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

  PersonModel({
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

  // 🔹 Factory para mapear desde Firestore
  factory PersonModel.fromFirestore(String id, Map<String, dynamic> data) {
    return PersonModel(
      id: id,
      address: data['address'] ?? '',
      civilStatus: data['civilStatus'] ?? '',
      dataEntryPerson: data['dataEntryPerson'] ?? Timestamp.now(),
      dateBirth: data['dateBirth'] ?? Timestamp.now(),
      dni: data['dni'] ?? '',
      emailMain: data['emailMain'] ?? '',
      emailSecondary: data['emailSecondary'] ?? '',
      genderPerson: data['genderPerson'] ?? '',
      imagePerson: data['imagePerson'] ?? '',
      motherSurname: data['motherSurname'] ?? '',
      nacionality: data['nacionality'] ?? '',
      namePerson: data['namePerson'] ?? '',
      numberCip: data['numberCip'] ?? '',
      numberPhone: data['numberPhone'] ?? '',
      paternalSurname: data['paternalSurname'] ?? '',
      personId: data['personId'] ?? '',
      ruc: data['ruc'] ?? '',
      statePerson: data['statePerson'] ?? false,
      isAdmin: data['isAdmin'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() => {
        "address": address,
        "civilStatus": civilStatus,
        "dataEntryPerson": dataEntryPerson,
        "dateBirth": dateBirth,
        "dni": dni,
        "emailMain": emailMain,
        "emailSecondary": emailSecondary,
        "genderPerson": genderPerson,
        "imagePerson": imagePerson,
        "motherSurname": motherSurname,
        "nacionality": nacionality,
        "namePerson": namePerson,
        "numberCip": numberCip,
        "numberPhone": numberPhone,
        "paternalSurname": paternalSurname,
        "personId": personId,
        "ruc": ruc,
        "specialityId": specialityId,
        "stateCollegiate": stateCollegiate,
        "statePerson": statePerson,
        "typePersonId": typePersonId,
        "isAdmin": isAdmin,
      };
  
}
