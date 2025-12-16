class SpecialityModel {
    final String? descriptionSpeciality;
    final String? id;
    final String? nameSpeciality;
    final bool? stateSpeciality;

    SpecialityModel({
        this.descriptionSpeciality,
        this.id,
        this.nameSpeciality,
        this.stateSpeciality,
    });

    factory SpecialityModel.fromJson(Map<String, dynamic> json) => SpecialityModel(
        descriptionSpeciality: json["descriptionSpeciality"],
        id: json["id"],
        nameSpeciality: json["nameSpeciality"],
        stateSpeciality: json["stateSpeciality"],
    );

    Map<String, dynamic> toJson() => {
        "descriptionSpeciality": descriptionSpeciality,
        "id": id,
        "nameSpeciality": nameSpeciality,
        "stateSpeciality": stateSpeciality,
    };
}