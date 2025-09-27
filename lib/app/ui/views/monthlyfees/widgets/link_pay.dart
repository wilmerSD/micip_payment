import 'dart:async';
import 'dart:js_interop';

@JS('openCulqiCheckout')
external void openCulqiCheckout(
  String publicKey,
  int amount,
  String currency,
  String email,
);

@JS('getCulqiToken')
external void getCulqiToken(JSFunction callback);

class CulqiWeb {
  static Future<String?> openCheckout({
    required String publicKey,
    required int amount,
    required String currency,
    required String email,
  }) async {
    final completer = Completer<String?>();

    // Como en JS ya envías Culqi.token.id (string),
    // aquí el parámetro es directamente un JSString
    getCulqiToken(
      ((JSString tokenId) {
        completer.complete(tokenId.toDart);
      }).toJS,
    );

    openCulqiCheckout(publicKey, amount, currency, email);

    return completer.future;
  }
}
