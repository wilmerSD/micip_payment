import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfAssets {
  static pw.MemoryImage? _logo;
  static pw.MemoryImage? _signature;

  static Future<pw.MemoryImage> getLogo() async {
    if (_logo == null) {
      final bytes = await rootBundle.load('assets/LOGO_CIP.png');
      _logo = pw.MemoryImage(bytes.buffer.asUint8List());
    }
    return _logo!;
  }
   static Future<pw.MemoryImage> getSignature() async {
    if (_signature == null) {
      final bytes = await rootBundle.load('assets/firma.png');
      _signature = pw.MemoryImage(bytes.buffer.asUint8List());
    }
    return _signature!;
  }
}
