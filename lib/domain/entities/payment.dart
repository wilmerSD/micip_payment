import 'package:cloud_firestore/cloud_firestore.dart';

class Payment {
    final String? id;
    final Timestamp? creationDatePay;
    final String? locationCityPay;
    final String? locationCountryPay;
    final GeoPoint? locationPay;
    final bool? paymentState;
    final int? paymentValue;
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

    Payment({
        this.id,
        this.creationDatePay,
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
}