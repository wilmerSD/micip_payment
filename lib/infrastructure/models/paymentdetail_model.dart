class PaymentdetailModel {
  final int? amountPaid;
  final DateTime? createdAt;
  final String? id;
  final String? paymentId;
  final String? referenceId;
  final int? referenceType;

  PaymentdetailModel({
    this.amountPaid,
    this.createdAt,
    this.id,
    this.paymentId,
    this.referenceId,
    this.referenceType,
  });

  factory PaymentdetailModel.fromJson(Map<String, dynamic> json) =>
      PaymentdetailModel(
        amountPaid: json["amountPaid"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        id: json["id"],
        paymentId: json["paymentId"],
        referenceId: json["referenceId"],
        referenceType: json["referenceType"],
      );

  Map<String, dynamic> toJson() => {
        "amountPaid": amountPaid,
        "createdAt": createdAt?.toIso8601String(),
        "id": id,
        "paymentId": paymentId,
        "referenceId": referenceId,
        "referenceType": referenceType,
      };
}
