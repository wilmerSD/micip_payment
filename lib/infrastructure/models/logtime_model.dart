import 'package:cloud_firestore/cloud_firestore.dart';

class LogtimeModel {
    final String? id;
    final String? personId;
    final String? cip;
    final String? dni;
    final String? fullNames;
    final Timestamp? paymentDateEnd;
    final Timestamp? paymentDateStart;
    final String? paymentId;
    final int? typePay;
    final String? typePayName;

    LogtimeModel({
        this.id,
        this.personId,
        this.cip,
        this.dni,
        this.fullNames,
        this.paymentDateEnd,
        this.paymentDateStart,
        this.paymentId,
        this.typePay,
        this.typePayName,
    });

    factory LogtimeModel.fromJson(Map<String, dynamic> json) => LogtimeModel(
        personId: json["personId"],
        cip: json["cip"],
        dni: json["dni"],
        fullNames: json["fullNames"],
        id: json["id"],
        paymentDateEnd: json["paymentDateEnd"],
        paymentDateStart: json["paymentDateStart"],
        paymentId: json["paymentId"],
        typePay: json["typePay"],
        typePayName: json["typePayName"],
    );

    Map<String, dynamic> toJson() => {
        "personId": personId,
        "cip": cip,
        "dni": dni,
        "fullNames": fullNames,
        "id": id,
        "paymentDateEnd": paymentDateEnd,
        "paymentDateStart": paymentDateStart,
        "paymentId": paymentId,
        "typePay": typePay,
        "typePayName": typePayName,
    };
}