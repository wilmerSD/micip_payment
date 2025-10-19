import 'package:flutter_dotenv/flutter_dotenv.dart';


// class Environment {

//   static String publicKeyCulqi = dotenv.env['PUBLIC_KEY_QA'] ?? 'No hay api key';


// }

class Environment {
  static String publicKeyCulqi = const String.fromEnvironment(
    'PUBLIC_KEY_QA',
    defaultValue: '',
  );

  static String get value {
    // Si la variable viene vacía del dart-define, intenta leer el .env local
    return publicKeyCulqi.isNotEmpty
        ? publicKeyCulqi
        : (dotenv.env['PUBLIC_KEY_QA'] ?? 'No hay api key');
  }
}