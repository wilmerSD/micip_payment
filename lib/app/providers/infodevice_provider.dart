import 'dart:core';
import 'dart:io';
import 'package:cip_payment_web/domain/entities/deviceinfo.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as locations;
import 'package:network_info_plus/network_info_plus.dart';

class InfodeviceProvider with ChangeNotifier {
  locations.Location location = locations.Location();
  locations.LocationData? locationData;
  double latitude = 0.0;
  double longitude = 0.0;
  String streetName = '';
  LatLng _currentLocation = const LatLng(0, 0);
  String ip = '';
  LatLng get currentLocation => _currentLocation;

  void updateLocation(LatLng newLocation) {
    _currentLocation = newLocation;
    notifyListeners(); // Esto notifica a los widgets que usan este provider
  }

  Future<DeviceInfo?> deviceInfo() async{
    try{
      getLocalIp();
      await checkLocationPermission();
      final deviceBrand = await getDeviceBrand();
      return DeviceInfo(
        nameDevice: deviceBrand,
        latitude: latitude,
        longitude: longitude,
        nameCity: city,
        nameCountry: country,
        ip: ip,
      );
    }catch(e){
      return null;
    }
  }
  //Chequear los permisos de ubicación
  Future<void> checkLocationPermission() async {
    final hasPermission = await location.hasPermission();
    if (hasPermission == locations.PermissionStatus.denied) {
      final requestPermission = await location.requestPermission();
      if (requestPermission != locations.PermissionStatus.granted) {
        //ha denegado los permisos de ubicación.
        // mensaje de error o solicitar permisos nuevamente.
        return;
      }
    }
    await getPosition();
    await getCityAndCountry();
  }

    //Optener ubicación actual
  Future<void>? getPosition() async {
    latitude = 0;
    longitude = 0;
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high, // equivalente al desiredAccuracy
        distanceFilter: 0, // opcional, en metros
      ),
    );
    latitude = position.latitude;
    longitude = position.longitude;
  }

  //Optener nombre de ubicación actual
  getNameLocation() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      streetName = placemark.street ?? '';
    } else {
      streetName = "Desconocido";
    }
  }

  String city = '';
  String country = '';

  Future<void> getCityAndCountry() async {
    city = '';
    country = '';
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];

        city = placemark.locality ?? 'Ciudad desconocida';
        country = placemark.country ?? 'País desconocido';
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getLocalIp() async {
    ip = '';
    final info = NetworkInfo();
    ip = await info.getWifiIP() ?? '';
    
  }

  Future<String> getDeviceBrand() async {
    final deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.brand; 
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo
            .name;
      } else {
        return "Plataforma desconocida";
      }
    } catch (e) {
      return "Error al obtener marca";
    }
  }
}
