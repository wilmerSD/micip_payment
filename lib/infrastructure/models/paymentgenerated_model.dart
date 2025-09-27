import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentgeneratedModel {
    final String? id;
    final int? amountToPay;
    final Timestamp? date;
    final String? personId;
    final String? typePayId;

    PaymentgeneratedModel({
        this.id,
        this.amountToPay,
        this.date,
        this.personId,
        this.typePayId,
    });

    factory PaymentgeneratedModel.fromJson(Map<String, dynamic> json) => PaymentgeneratedModel(
        id: json["id"],
        amountToPay: json["amountToPay"],
        date: json['date'] ?? Timestamp.now(),
        personId: json["personId"],
        typePayId: json["typePayId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "amountToPay": amountToPay,
        "date": date,
        "personId": personId,
        "typePayId": typePayId,
    };
}