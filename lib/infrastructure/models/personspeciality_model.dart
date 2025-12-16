class PersonspecialityModel {
    final String? personId;
    final String? specialityId;

    PersonspecialityModel({
        this.personId,
        this.specialityId,
    });

    factory PersonspecialityModel.fromJson(Map<String, dynamic> json) => PersonspecialityModel(
        personId: json["personId"],
        specialityId: json["specialityId"],
    );

    Map<String, dynamic> toJson() => {
        "personId": personId,
        "specialityId": specialityId,
    };
}
