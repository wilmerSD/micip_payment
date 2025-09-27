class CulqiTokenSuccessResponse {
    final String? object;
    final String? id;
    final String? type;
    final String? email;
    final int? creationDate;
    final String? cardNumber;
    final String? lastFour;
    final bool? active;
    final Iin? iin;
    final Client? client;
    final Metadata? metadata;

    CulqiTokenSuccessResponse({
        this.object,
        this.id,
        this.type,
        this.email,
        this.creationDate,
        this.cardNumber,
        this.lastFour,
        this.active,
        this.iin,
        this.client,
        this.metadata,
    });

    factory CulqiTokenSuccessResponse.fromJson(Map<String, dynamic> json) => CulqiTokenSuccessResponse(
        object: json["object"],
        id: json["id"],
        type: json["type"],
        email: json["email"],
        creationDate: json["creation_date"],
        cardNumber: json["card_number"],
        lastFour: json["last_four"],
        active: json["active"],
        iin: json["iin"] == null ? null : Iin.fromJson(json["iin"]),
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
        metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
    );

    Map<String, dynamic> toJson() => {
        "object": object,
        "id": id,
        "type": type,
        "email": email,
        "creation_date": creationDate,
        "card_number": cardNumber,
        "last_four": lastFour,
        "active": active,
        "iin": iin?.toJson(),
        "client": client?.toJson(),
        "metadata": metadata?.toJson(),
    };
}

class Client {
    final String? ip;
    final String? ipCountry;
    final String? ipCountryCode;
    final String? browser;
    final dynamic deviceFingerprint;
    final String? deviceType;

    Client({
        this.ip,
        this.ipCountry,
        this.ipCountryCode,
        this.browser,
        this.deviceFingerprint,
        this.deviceType,
    });

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        ip: json["ip"],
        ipCountry: json["ip_country"],
        ipCountryCode: json["ip_country_code"],
        browser: json["browser"],
        deviceFingerprint: json["device_fingerprint"],
        deviceType: json["device_type"],
    );

    Map<String, dynamic> toJson() => {
        "ip": ip,
        "ip_country": ipCountry,
        "ip_country_code": ipCountryCode,
        "browser": browser,
        "device_fingerprint": deviceFingerprint,
        "device_type": deviceType,
    };
}

class Iin {
    final String? object;
    final String? bin;
    final String? cardBrand;
    final String? cardType;
    final String? cardCategory;
    final Issuer? issuer;
    final List<int>? installmentsAllowed;

    Iin({
        this.object,
        this.bin,
        this.cardBrand,
        this.cardType,
        this.cardCategory,
        this.issuer,
        this.installmentsAllowed,
    });

    factory Iin.fromJson(Map<String, dynamic> json) => Iin(
        object: json["object"],
        bin: json["bin"],
        cardBrand: json["card_brand"],
        cardType: json["card_type"],
        cardCategory: json["card_category"],
        issuer: json["issuer"] == null ? null : Issuer.fromJson(json["issuer"]),
        installmentsAllowed: json["installments_allowed"] == null ? [] : List<int>.from(json["installments_allowed"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "object": object,
        "bin": bin,
        "card_brand": cardBrand,
        "card_type": cardType,
        "card_category": cardCategory,
        "issuer": issuer?.toJson(),
        "installments_allowed": installmentsAllowed == null ? [] : List<dynamic>.from(installmentsAllowed!.map((x) => x)),
    };
}

class Issuer {
    final String? name;
    final String? country;
    final String? countryCode;
    final String? website;
    final String? phoneNumber;

    Issuer({
        this.name,
        this.country,
        this.countryCode,
        this.website,
        this.phoneNumber,
    });

    factory Issuer.fromJson(Map<String, dynamic> json) => Issuer(
        name: json["name"],
        country: json["country"],
        countryCode: json["country_code"],
        website: json["website"],
        phoneNumber: json["phone_number"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "country": country,
        "country_code": countryCode,
        "website": website,
        "phone_number": phoneNumber,
    };
}

class Metadata {
    Metadata();

    factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    );

    Map<String, dynamic> toJson() => {
    };
}