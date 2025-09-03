import 'package:http/http.dart' as http;
import 'dart:convert';

class CulqiService {
  
  Future<String?> crearTokenCulqi({
    required String cardNumber,
    required String cvv,
    required String expirationMonth,
    required String expirationYear,
    required String email,
  }) async {
    final url = Uri.parse("https://api.culqi.com/v2/tokens");
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json", // importante
      "Authorization": "Bearer pk_test_sKWDD6bVub17VOqt", // Reemplaza con tu llave pública real
    };

    final body = {
      "card_number": cardNumber,
      "cvv": cvv,
      "expiration_month": expirationMonth,
      "expiration_year": expirationYear,
      "email": email,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return data['id']; // este es el token
    } else {
      print("Error creando token: ${response.body}");
      return null;
    }
  }

  Future<bool> payCulqui(String token, double amount, String email) async {
    final response = await http.post(
      Uri.parse("http://192.168.100.51:8080/pago"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "token": token,
        "amount": amount, // S/10.00
        "email": email //"usuario@example.com",
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
