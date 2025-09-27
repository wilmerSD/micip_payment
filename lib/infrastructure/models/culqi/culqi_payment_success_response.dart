class CulqiPaymentSuccessResponse {
    final String? object;
    final String? id;
    final int? creationDate;
    final int? amount;
    final int? amountRefunded;
    final int? currentAmount;
    final int? installments;
    final int? installmentsAmount;
    final String? currencyCode;
    final String? email;
    final dynamic description;
    final Source? source;
    final Outcome? outcome;
    final double? fraudScore;
    final AntifraudDetails? antifraudDetails;
    final bool? dispute;
    final dynamic capture;
    final dynamic partial;
    final int? captureDate;
    final String? referenceCode;
    final String? authorizationCode;
    final bool? duplicated;
    final Metadata? metadata;
    final int? totalFee;
    final int? netAmount;
    final FeeDetails? feeDetails;
    final int? totalFeeTaxes;
    final int? transferAmount;
    final bool? paid;
    final String? statementDescriptor;
    final dynamic transferId;

    CulqiPaymentSuccessResponse({
        this.object,
        this.id,
        this.creationDate,
        this.amount,
        this.amountRefunded,
        this.currentAmount,
        this.installments,
        this.installmentsAmount,
        this.currencyCode,
        this.email,
        this.description,
        this.source,
        this.outcome,
        this.fraudScore,
        this.antifraudDetails,
        this.dispute,
        this.capture,
        this.partial,
        this.captureDate,
        this.referenceCode,
        this.authorizationCode,
        this.duplicated,
        this.metadata,
        this.totalFee,
        this.netAmount,
        this.feeDetails,
        this.totalFeeTaxes,
        this.transferAmount,
        this.paid,
        this.statementDescriptor,
        this.transferId,
    });

    factory CulqiPaymentSuccessResponse.fromJson(Map<String, dynamic> json) => CulqiPaymentSuccessResponse(
        object: json["object"],
        id: json["id"],
        creationDate: json["creation_date"],
        amount: json["amount"],
        amountRefunded: json["amount_refunded"],
        currentAmount: json["current_amount"],
        installments: json["installments"],
        installmentsAmount: json["installments_amount"],
        currencyCode: json["currency_code"],
        email: json["email"],
        description: json["description"],
        source: json["source"] == null ? null : Source.fromJson(json["source"]),
        outcome: json["outcome"] == null ? null : Outcome.fromJson(json["outcome"]),
        fraudScore: json["fraud_score"]?.toDouble(),
        antifraudDetails: json["antifraud_details"] == null ? null : AntifraudDetails.fromJson(json["antifraud_details"]),
        dispute: json["dispute"],
        capture: json["capture"],
        partial: json["partial"],
        captureDate: json["capture_date"],
        referenceCode: json["reference_code"],
        authorizationCode: json["authorization_code"],
        duplicated: json["duplicated"],
        metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
        totalFee: json["total_fee"],
        netAmount: json["net_amount"],
        feeDetails: json["fee_details"] == null ? null : FeeDetails.fromJson(json["fee_details"]),
        totalFeeTaxes: json["total_fee_taxes"],
        transferAmount: json["transfer_amount"],
        paid: json["paid"],
        statementDescriptor: json["statement_descriptor"],
        transferId: json["transfer_id"],
    );

    Map<String, dynamic> toJson() => {
        "object": object,
        "id": id,
        "creation_date": creationDate,
        "amount": amount,
        "amount_refunded": amountRefunded,
        "current_amount": currentAmount,
        "installments": installments,
        "installments_amount": installmentsAmount,
        "currency_code": currencyCode,
        "email": email,
        "description": description,
        "source": source?.toJson(),
        "outcome": outcome?.toJson(),
        "fraud_score": fraudScore,
        "antifraud_details": antifraudDetails?.toJson(),
        "dispute": dispute,
        "capture": capture,
        "partial": partial,
        "capture_date": captureDate,
        "reference_code": referenceCode,
        "authorization_code": authorizationCode,
        "duplicated": duplicated,
        "metadata": metadata?.toJson(),
        "total_fee": totalFee,
        "net_amount": netAmount,
        "fee_details": feeDetails?.toJson(),
        "total_fee_taxes": totalFeeTaxes,
        "transfer_amount": transferAmount,
        "paid": paid,
        "statement_descriptor": statementDescriptor,
        "transfer_id": transferId,
    };
}

class AntifraudDetails {
    final String? object;
    final dynamic countryCode;
    final String? firstName;
    final String? lastName;
    final dynamic addressCity;
    final dynamic address;
    final dynamic phone;

    AntifraudDetails({
        this.object,
        this.countryCode,
        this.firstName,
        this.lastName,
        this.addressCity,
        this.address,
        this.phone,
    });

    factory AntifraudDetails.fromJson(Map<String, dynamic> json) => AntifraudDetails(
        object: json["object"],
        countryCode: json["country_code"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        addressCity: json["address_city"],
        address: json["address"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "object": object,
        "country_code": countryCode,
        "first_name": firstName,
        "last_name": lastName,
        "address_city": addressCity,
        "address": address,
        "phone": phone,
    };
}

class FeeDetails {
    final FixedFee? fixedFee;
    final VariableFee? variableFee;

    FeeDetails({
        this.fixedFee,
        this.variableFee,
    });

    factory FeeDetails.fromJson(Map<String, dynamic> json) => FeeDetails(
        fixedFee: json["fixed_fee"] == null ? null : FixedFee.fromJson(json["fixed_fee"]),
        variableFee: json["variable_fee"] == null ? null : VariableFee.fromJson(json["variable_fee"]),
    );

    Map<String, dynamic> toJson() => {
        "fixed_fee": fixedFee?.toJson(),
        "variable_fee": variableFee?.toJson(),
    };
}

class FixedFee {
    final int? amount;
    final String? currencyCode;
    final int? exchangeRate;
    final String? exchangeRateCurrencyCode;
    final int? total;

    FixedFee({
        this.amount,
        this.currencyCode,
        this.exchangeRate,
        this.exchangeRateCurrencyCode,
        this.total,
    });

    factory FixedFee.fromJson(Map<String, dynamic> json) => FixedFee(
        amount: json["amount"],
        currencyCode: json["currency_code"],
        exchangeRate: json["exchange_rate"],
        exchangeRateCurrencyCode: json["exchange_rate_currency_code"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "currency_code": currencyCode,
        "exchange_rate": exchangeRate,
        "exchange_rate_currency_code": exchangeRateCurrencyCode,
        "total": total,
    };
}

class VariableFee {
    final String? currencyCode;
    final int? commission;
    final int? total;

    VariableFee({
        this.currencyCode,
        this.commission,
        this.total,
    });

    factory VariableFee.fromJson(Map<String, dynamic> json) => VariableFee(
        currencyCode: json["currency_code"],
        commission: json["commission"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "currency_code": currencyCode,
        "commission": commission,
        "total": total,
    };
}

class Metadata {
    Metadata();

    factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Outcome {
    final String? type;
    final String? code;
    final String? merchantMessage;
    final String? userMessage;

    Outcome({
        this.type,
        this.code,
        this.merchantMessage,
        this.userMessage,
    });

    factory Outcome.fromJson(Map<String, dynamic> json) => Outcome(
        type: json["type"],
        code: json["code"],
        merchantMessage: json["merchant_message"],
        userMessage: json["user_message"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "code": code,
        "merchant_message": merchantMessage,
        "user_message": userMessage,
    };
}

class Source {
    final String? object;
    final String? id;
    final String? type;
    final int? creationDate;
    final String? email;
    final String? cardNumber;
    final String? lastFour;
    final bool? active;
    final Iin? iin;
    final Client? client;
    final dynamic metadata;

    Source({
        this.object,
        this.id,
        this.type,
        this.creationDate,
        this.email,
        this.cardNumber,
        this.lastFour,
        this.active,
        this.iin,
        this.client,
        this.metadata,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        object: json["object"],
        id: json["id"],
        type: json["type"],
        creationDate: json["creation_date"],
        email: json["email"],
        cardNumber: json["card_number"],
        lastFour: json["last_four"],
        active: json["active"],
        iin: json["iin"] == null ? null : Iin.fromJson(json["iin"]),
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
        metadata: json["metadata"],
    );

    Map<String, dynamic> toJson() => {
        "object": object,
        "id": id,
        "type": type,
        "creation_date": creationDate,
        "email": email,
        "card_number": cardNumber,
        "last_four": lastFour,
        "active": active,
        "iin": iin?.toJson(),
        "client": client?.toJson(),
        "metadata": metadata,
    };
}

class Client {
    final String? ip;
    final String? browser;
    final String? ipCountry;
    final String? deviceType;
    final String? ipCountryCode;
    final dynamic deviceFingerprint;

    Client({
        this.ip,
        this.browser,
        this.ipCountry,
        this.deviceType,
        this.ipCountryCode,
        this.deviceFingerprint,
    });

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        ip: json["ip"],
        browser: json["browser"],
        ipCountry: json["ip_country"],
        deviceType: json["device_type"],
        ipCountryCode: json["ip_country_code"],
        deviceFingerprint: json["device_fingerprint"],
    );

    Map<String, dynamic> toJson() => {
        "ip": ip,
        "browser": browser,
        "ip_country": ipCountry,
        "device_type": deviceType,
        "ip_country_code": ipCountryCode,
        "device_fingerprint": deviceFingerprint,
    };
}

class Iin {
    final String? bin;
    final Issuer? issuer;
    final String? object;
    final String? cardType;
    final String? cardBrand;
    final String? cardCategory;
    final List<int>? installmentsAllowed;

    Iin({
        this.bin,
        this.issuer,
        this.object,
        this.cardType,
        this.cardBrand,
        this.cardCategory,
        this.installmentsAllowed,
    });

    factory Iin.fromJson(Map<String, dynamic> json) => Iin(
        bin: json["bin"],
        issuer: json["issuer"] == null ? null : Issuer.fromJson(json["issuer"]),
        object: json["object"],
        cardType: json["card_type"],
        cardBrand: json["card_brand"],
        cardCategory: json["card_category"],
        installmentsAllowed: json["installments_allowed"] == null ? [] : List<int>.from(json["installments_allowed"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "bin": bin,
        "issuer": issuer?.toJson(),
        "object": object,
        "card_type": cardType,
        "card_brand": cardBrand,
        "card_category": cardCategory,
        "installments_allowed": installmentsAllowed == null ? [] : List<dynamic>.from(installmentsAllowed!.map((x) => x)),
    };
}

class Issuer {
    final String? name;
    final String? country;
    final String? website;
    final String? countryCode;
    final String? phoneNumber;

    Issuer({
        this.name,
        this.country,
        this.website,
        this.countryCode,
        this.phoneNumber,
    });

    factory Issuer.fromJson(Map<String, dynamic> json) => Issuer(
        name: json["name"],
        country: json["country"],
        website: json["website"],
        countryCode: json["country_code"],
        phoneNumber: json["phone_number"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "country": country,
        "website": website,
        "country_code": countryCode,
        "phone_number": phoneNumber,
    };
}