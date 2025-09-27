import 'package:cloud_firestore/cloud_firestore.dart';

class QuotaModel {
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

  QuotaModel({
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

  factory QuotaModel.fromFirestore(Map<String, dynamic> json) => QuotaModel(
    id: json["id"],
    personId: json["personId"],
    namePerson: json["namePerson"],
    motherSurname: json["motherSurname"],
    paternalSurname: json["paternalSurname"],
    dni: json["dni"],
    amount: json["amount"],
    feeMonth: json["feeMonth"],
    feeYear: json["feeYear"],
    status: json["status"],
    createdAt: json['createdAt'] ?? Timestamp.now(),
    updatedAt: json['updatedAt'] ?? Timestamp.now(),
    dueDate: json['dueDate'] ?? Timestamp.now(),
    fullNamePerson: json["fullNamePerson"] ?? '',
    isSelected: false,
    
  );

  Map<String, dynamic> toFirestore() => {
    "id": id,
    "personId": personId,
    "namePerson": namePerson,
    "motherSurname": motherSurname,
    "paternalSurname": paternalSurname,
    "dni": dni,
    "amount": amount,
    "feeMonth": feeMonth,
    "feeYear": feeYear,
    "status": status,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "dueDate": dueDate,
    "fullNamePerson": fullNamePerson,
    "personMonthYear": "$personId-$feeMonth-$feeYear", 
  };
}
