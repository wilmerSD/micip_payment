class UserModel {
    final String? personId;
    final bool? stateUser;
    final String? userName;
    final String? password;

    UserModel({
        this.personId,
        this.stateUser,
        this.userName,
        this.password,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        personId: json["personId"],
        stateUser: json["stateUser"],
        userName: json["userName"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "personId": personId,
        "stateUser": stateUser,
        "userName": userName,
        "password": password,
    };
}
