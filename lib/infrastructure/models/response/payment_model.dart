import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  final String? id;
  final Timestamp? creationDatePay;
  final String? deviceInfoPay;
  final String? ipAddressPay;
  final String? locationCityPay;
  final String? locationCountryPay;
  final GeoPoint? locationPay;
  final bool? paymentState;
  final double? paymentValue;
  final String? personId;
  final String? platformPayment;
  final int? quantityPayment;
  final int? receiptType;
  final int? typePay;
  final int? paymentChannel;
  final String? rucId;
  final int? feeMonth;
  final int? feeYear;
  final String? specialtyId;

  PaymentModel({
    this.id,
    this.creationDatePay,
    this.deviceInfoPay,
    this.ipAddressPay,
    this.locationCityPay,
    this.locationCountryPay,
    this.locationPay,
    this.paymentState,
    this.paymentValue,
    this.personId,
    this.platformPayment,
    this.quantityPayment,
    this.receiptType,
    this.typePay,
    this.paymentChannel,
    this.rucId,
    this.feeMonth,
    this.feeYear,
    this.specialtyId,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
      id: json["id"],
      creationDatePay: json["creationDatePay"],
      deviceInfoPay: json["deviceInfoPay"],
      ipAddressPay: json["ipAddressPay"],
      locationCityPay: json["locationCityPay"],
      locationCountryPay: json["locationCountryPay"],
      locationPay:
          json['locationPay'] != null ? json['locationPay'] as GeoPoint : null,
      paymentState: json["paymentState"],
      paymentValue: json["paymentValue"]?.toDouble(),
      personId: json["personId"],
      platformPayment: json["platformPayment"],
      quantityPayment: json["quantityPayment"],
      receiptType: json["receiptType"],
      typePay: json["typePay"],
      paymentChannel: json["paymentChannel"],
      rucId: json["rucId"],
      feeMonth: json["feeMonth"],
      feeYear: json["feeYear"],
      specialtyId: json["specialtyId"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "creationDatePay": creationDatePay,
        "deviceInfoPay": deviceInfoPay,
        "ipAddressPay": ipAddressPay,
        "locationCityPay": locationCityPay,
        "locationCountryPay": locationCountryPay,
        "locationPay": locationPay,
        "paymentState": paymentState,
        "paymentValue": paymentValue,
        "personId": personId,
        "platformPayment": platformPayment,
        "quantityPayment": quantityPayment,
        "receiptType": receiptType,
        "typePay": typePay,
        "paymentChannel": paymentChannel,
        "rucId": rucId,
        "feeMonth": feeMonth,
        "feeYear": feeYear,
        "specialtyId": specialtyId,
      };
}
