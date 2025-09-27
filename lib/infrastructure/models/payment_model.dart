class PaymentModel {
    final DateTime? creationDatePay;
    final String? deviceInfoPay;
    final String? ipAddressPay;
    final String? locationCityPay;
    final String? locationCountryPay;
    final LocationPay? locationPay;
    final DateTime? paymentDate;
    final bool? paymentState;
    final double? paymentValue;
    final String? personId;
    final String? platformPayment;
    final int? quantityPayment;
    final int? receiptFormatPay;
    final int? receiptTypePay;

    PaymentModel({
        this.creationDatePay,
        this.deviceInfoPay,
        this.ipAddressPay,
        this.locationCityPay,
        this.locationCountryPay,
        this.locationPay,
        this.paymentDate,
        this.paymentState,
        this.paymentValue,
        this.personId,
        this.platformPayment,
        this.quantityPayment,
        this.receiptFormatPay,
        this.receiptTypePay,
    });

    factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        creationDatePay: json["creationDatePay"] == null ? null : DateTime.parse(json["creationDatePay"]),
        deviceInfoPay: json["deviceInfoPay"],
        ipAddressPay: json["ipAddressPay"],
        locationCityPay: json["locationCityPay"],
        locationCountryPay: json["locationCountryPay"],
        locationPay: json["locationPay"] == null ? null : LocationPay.fromJson(json["locationPay"]),
        paymentDate: json["paymentDate"] == null ? null : DateTime.parse(json["paymentDate"]),
        paymentState: json["paymentState"],
        paymentValue: json["paymentValue"]?.toDouble(),
        personId: json["personId"],
        platformPayment: json["platformPayment"],
        quantityPayment: json["quantityPayment"],
        receiptFormatPay: json["receiptFormatPay"],
        receiptTypePay: json["receiptTypePay"],
    );

    Map<String, dynamic> toJson() => {
        "creationDatePay": creationDatePay?.toIso8601String(),
        "deviceInfoPay": deviceInfoPay,
        "ipAddressPay": ipAddressPay,
        "locationCityPay": locationCityPay,
        "locationCountryPay": locationCountryPay,
        "locationPay": locationPay?.toJson(),
        "paymentDate": paymentDate?.toIso8601String(),
        "paymentState": paymentState,
        "paymentValue": paymentValue,
        "personId": personId,
        "platformPayment": platformPayment,
        "quantityPayment": quantityPayment,
        "receiptFormatPay": receiptFormatPay,
        "receiptTypePay": receiptTypePay,
    };
}

class LocationPay {
    final int? latitude;
    final int? longitude;

    LocationPay({
        this.latitude,
        this.longitude,
    });

    factory LocationPay.fromJson(Map<String, dynamic> json) => LocationPay(
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}