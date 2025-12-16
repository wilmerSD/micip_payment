import 'package:cloud_firestore/cloud_firestore.dart';

class Log {
    final String? cip;
    final String? dni;
    final String? fullNames;
    final String? id;
    final String? personId;
    final Timestamp? paymentDateEnd;
    final Timestamp? paymentDateStart;
    final String? paymentId;
    final int? typePay;
    final String? typePayName;

    Log({
        this.cip,
        this.dni,
        this.fullNames,
        this.id,
        this.paymentDateEnd,
        this.paymentDateStart,
        this.paymentId,
        this.typePay,
        this.typePayName,
        this.personId,
    });
}