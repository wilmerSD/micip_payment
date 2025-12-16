class DeviceInfo {
    final String? nameDevice;
    final double? latitude;
    final double? longitude;
    final String? nameCity;
    final String? nameCountry;
    final String? ip;

    DeviceInfo({
        this.nameDevice,
        this.latitude,
        this.longitude,
        this.nameCity,
        this.nameCountry,
        this.ip,
    });

    factory DeviceInfo.fromJson(Map<String, dynamic> json) => DeviceInfo(
        nameDevice: json["nameDevice"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        nameCity: json["nameCity"],
        nameCountry: json["nameCountry"],
        ip: json["ip"],
    );

    Map<String, dynamic> toJson() => {
        "nameDevice": nameDevice,
        "latitude": latitude,
        "longitude": longitude,
        "nameCity": nameCity,
        "nameCountry": nameCountry,
        "ip": ip,
    };
}