
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUser {
  static late SharedPreferences _prefs;

  static String get personId => _prefs.getString('personId') ?? '';
  static set personId(String value) => _prefs.setString('personId', value);

  static Future init() async{
    _prefs = await SharedPreferences.getInstance();
  }

  String get lastPage {
    return _prefs.getString('ultimaPagina') ?? 'Login';
  }

  set lastPage(String value){
    _prefs.setString('ultimaPagina', value);
  }


  bool get themeBool {
    return _prefs.getBool('themeBool') ?? false;
  }

  set themeBool(bool value){
    _prefs.setBool('themeBool', value);
  }
}