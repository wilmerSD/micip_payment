class CulqiErrorResponse {
    final String? object;
    final String? type;
    final String? code;
    final String? merchantMessage;
    final String? userMessage;
    final String? param;

    CulqiErrorResponse({
        this.object,
        this.type,
        this.code,
        this.merchantMessage,
        this.userMessage,
        this.param,
    });

    factory CulqiErrorResponse.fromJson(Map<String, dynamic> json) => CulqiErrorResponse(
        object: json["object"],
        type: json["type"],
        code: json["code"],
        merchantMessage: json["merchant_message"],
        userMessage: json["user_message"],
        param: json["param"],
    );

    Map<String, dynamic> toJson() => {
        "object": object,
        "type": type,
        "code": code,
        "merchant_message": merchantMessage,
        "user_message": userMessage,
        "param": param,
    };
}