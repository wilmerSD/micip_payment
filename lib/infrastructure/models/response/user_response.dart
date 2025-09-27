class UserResponse {
    final String? password;
    final String? personId;
    final bool? stateUser;
    final String? userName;

    UserResponse({
        this.password,
        this.personId,
        this.stateUser,
        this.userName,
    });

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        password: json["password"],
        personId: json["personId"],
        stateUser: json["stateUser"],
        userName: json["userName"],
    );

    Map<String, dynamic> toJson() => {
        "password": password,
        "personId": personId,
        "stateUser": stateUser,
        "userName": userName,
    };
}