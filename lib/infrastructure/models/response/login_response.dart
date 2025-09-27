class LoginResponse {
    final String? status;
    final int? code;
    final List<DataPersonal>? data;

    LoginResponse({
        this.status,
        this.code,
        this.data,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        code: json["code"],
        data: json["data"] == null ? [] : List<DataPersonal>.from(json["data"]!.map((x) => DataPersonal.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class DataPersonal {
    final int? idColegiado;
    final String? codCli;
    final String? dni;
    final int? cip;
    final String? categoria;
    final String? nombre;
    final String? paterno;
    final String? materno;
    final String? colegiado;
    final DateTime? fechaNac;
    final int? edad;
    final int? genero;
    final String? estCivil;
    final String? correo;
    final String? celular;
    final String? direccion;
    final String? clave;

    DataPersonal({
        this.idColegiado,
        this.codCli,
        this.dni,
        this.cip,
        this.categoria,
        this.nombre,
        this.paterno,
        this.materno,
        this.colegiado,
        this.fechaNac,
        this.edad,
        this.genero,
        this.estCivil,
        this.correo,
        this.celular,
        this.direccion,
        this.clave,
    });

    factory DataPersonal.fromJson(Map<String, dynamic> json) => DataPersonal(
        idColegiado: json["IdColegiado"],
        codCli: json["CodCli"],
        dni: json["DNI"],
        cip: json["CIP"],
        categoria: json["Categoria"],
        nombre: json["Nombre"],
        paterno: json["Paterno"],
        materno: json["Materno"],
        colegiado: json["Colegiado"],
        fechaNac: json["FechaNac"] == null ? null : DateTime.parse(json["FechaNac"]),
        edad: json["Edad"],
        genero: json["Genero"],
        estCivil: json["EstCivil"],
        correo: json["Correo"],
        celular: json["Celular"],
        direccion: json["Direccion"],
        clave: json["Clave"],
    );

    Map<String, dynamic> toJson() => {
        "IdColegiado": idColegiado,
        "CodCli": codCli,
        "DNI": dni,
        "CIP": cip,
        "Categoria": categoria,
        "Nombre": nombre,
        "Paterno": paterno,
        "Materno": materno,
        "Colegiado": colegiado,
        "FechaNac": "${fechaNac!.year.toString().padLeft(4, '0')}-${fechaNac!.month.toString().padLeft(2, '0')}-${fechaNac!.day.toString().padLeft(2, '0')}",
        "Edad": edad,
        "Genero": genero,
        "EstCivil": estCivil,
        "Correo": correo,
        "Celular": celular,
        "Direccion": direccion,
        "Clave": clave,
    };
}