import 'package:cloud_firestore/cloud_firestore.dart';

class Quota {
  final String? id;
  final String? personId;
  final String? namePerson;
  final String? motherSurname;
  final String? paternalSurname;
  final String? dni;
  final String? fullNamePerson;
  final double? amount;
  final int? feeMonth;
  final int? feeYear;
  final String? status;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;
  final Timestamp? dueDate;
  bool isSelected;

  Quota({
    this.id,
    this.personId,
    this.namePerson,
    this.motherSurname,
    this.paternalSurname,
    this.dni,
    this.amount,
    this.feeMonth,
    this.feeYear,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.dueDate,
    this.fullNamePerson,
    required this.isSelected,
  });
}
