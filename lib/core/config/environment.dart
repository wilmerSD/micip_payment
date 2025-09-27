import 'package:flutter_dotenv/flutter_dotenv.dart';


class Environment {

  static String publicKeyCulqi = dotenv.env['PUBLIC_KEY_QA'] ?? 'No hay api key';


}