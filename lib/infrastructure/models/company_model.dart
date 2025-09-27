class CompanyModel {
  final String? id;
  final String? address;
  final String? businessName;
  final DateTime? createdAt;
  final String? email;
  final String? personId;
  final String? phone;
  final String? ruc;
  final bool? status;
  final String? tradeName;
  final DateTime? updatedAt;

  CompanyModel({
    this.id,
    this.address,
    this.businessName,
    this.createdAt,
    this.email,
    this.personId,
    this.phone,
    this.ruc,
    this.status,
    this.tradeName,
    this.updatedAt,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
    id: json["id"],
    address: json["address"],
    businessName: json["businessName"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    email: json["email"],
    personId: json["personId"],
    phone: json["phone"],
    ruc: json["ruc"],
    status: json["status"],
    tradeName: json["tradeName"],
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "businessName": businessName,
    "createdAt": createdAt?.toIso8601String(),
    "email": email,
    "personId": personId,
    "phone": phone,
    "ruc": ruc,
    "status": status,
    "tradeName": tradeName,
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
