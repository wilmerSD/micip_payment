import 'package:cip_payment_web/core/helpers/pdf_assets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> generateNoDebtCertificateIsolate(Map<String, dynamic> data) async {
  final logo = await PdfAssets.getLogo();
  final signature = await PdfAssets.getSignature();

  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.symmetric(horizontal: 50, vertical: 40),
      build: (pw.Context context) {
        return pw.Stack(
          children: [
            pw.Positioned.fill(
              child: pw.Opacity(
                opacity: 0.08,
                child: pw.Center(
                  child: pw.Container(
                    width: 300,
                    height: 300,
                    child: pw.Image(logo, fit: pw.BoxFit.cover),
                  ),
                ),
              ),
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                      width: 70,
                      height: 70,
                      child: pw.Image(logo, fit: pw.BoxFit.cover),
                    ),
                    pw.Column(
                      children: [
                        pw.Text(
                          'COLEGIO DE INGENIEROS DEL PERÚ',
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          'Consejo Departamental de ${data['council']}',
                          style: const pw.TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    pw.SizedBox(width: 70),
                  ],
                ),
                pw.SizedBox(height: 25),
                pw.Text(
                  'EL QUE SUSCRIBE DECANO DEL CONSEJO DEPARTAMENTAL DE ${data['council'].toString().toUpperCase()} - '
                  'COLEGIO DE INGENIEROS DEL PERÚ, otorga la presente:',
                  textAlign: pw.TextAlign.justify,
                  style: const pw.TextStyle(fontSize: 11),
                ),
                pw.SizedBox(height: 20),
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black),
                  ),
                  child: pw.Text(
                    'CONSTANCIA DE NO ADEUDO',
                    style: pw.TextStyle(
                      fontSize: 13,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'A favor del: Ing. ${data['name']}',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 15),
                pw.Text(
                  'De la especialidad en ${data['specialty']} con Reg. CIP N° ${data['cipNumber']}, adscrito al Consejo Departamental de ${data['council']} '
                  'del Colegio de Ingenieros del Perú, quien ha pagado sus cotizaciones hasta el mes de ${data['monthYear']}, '
                  'encontrándose habilitado en este período, para el cambio de SEDE correspondiente.',
                  style: const pw.TextStyle(fontSize: 11),
                  textAlign: pw.TextAlign.justify,
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'POR TANTO',
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Se expide la presente solicitud del interesado(a) para los fines que estime conveniente.',
                  style: const pw.TextStyle(fontSize: 11),
                  textAlign: pw.TextAlign.justify,
                ),
                pw.SizedBox(height: 40),
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    data['dateText'],
                    style: const pw.TextStyle(fontSize: 11),
                  ),
                ),
                pw.Spacer(),
                pw.Align(
                  alignment: pw.Alignment.bottomCenter,
                  child: pw.Column(
                    children: [
                      pw.Container(width: 80, height: 70, child: pw.Image(signature)),
                      pw.Container(
                        width: 150,
                        child: pw.Divider(thickness: 0.5, height: 1),
                      ),
                      pw.SizedBox(height: 5.0),
                      pw.Text(
                        'Consejo Departamental del\nColegio de Ingenieros del Perú',
                        style: const pw.TextStyle(fontSize: 10),
                        textAlign: pw.TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );

  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/constancia_no_adeudo.pdf');
  await file.writeAsBytes(await pdf.save());
    // 🔸 devolvemos solo la ruta
  return file.path;
}
