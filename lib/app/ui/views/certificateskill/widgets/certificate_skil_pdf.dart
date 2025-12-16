import 'dart:io';
import 'package:cip_payment_web/core/helpers/pdf_assets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

Future<void> generateCertificateSkill({
  required String name,
  required String council,
  required String cipNumber,
  required String incorporationDate,
  required String specialty,
  required String subject,
  required String owner,
  required String place,
  required String dateText,
}) async {
  final logo = await PdfAssets.getLogo();
  final signature = await PdfAssets.getSignature();
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(40),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Encabezado
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  width: 70,
                  height: 70,
                  child: pw.Image(logo, fit: pw.BoxFit.cover),
                ),
                // pw.SizedBox(width: 8.0),
                /*  pw.Container(
                  width: 70,
                  height: 70,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey),
                  ),
                  child: pw.Center(
                    child: pw.Text(
                      'LOGO',
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                  ),
                ), */
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      'COLEGIO DE INGENIEROS DEL PERÚ',
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.red,
                      ),
                    ),
                    pw.Text(
                      'Certificado de Habilidad',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.red,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(width: 70), // espacio para equilibrar
              ],
            ),

            pw.SizedBox(height: 25),
            pw.Text('Lo que suscriben certifican que:',
                style: const pw.TextStyle(fontSize: 11)),
            pw.SizedBox(height: 10),
            pw.Text('El ingeniero(a): $name'),
            pw.Text('Adscrito al consejo departamental: $council'),
            pw.Text(
                'Con registro de matrícula del CIP N°: $cipNumber        Fecha de incorporación: $incorporationDate'),
            pw.Text('Especialidad: $specialty'),
            pw.SizedBox(height: 15),

            pw.Text(
              'De conformidad con la Ley n°28858, Ley que complementa a la Ley N° 16053 del Ejercicio Profesional y el Estatuto del Colegio de Ingenieros del Perú, '
              'SE ENCUENTRA COLEGIADO Y HÁBIL, en consecuencia está autorizado para ejercer la Profesión de Ingeniero(a).',
              style: const pw.TextStyle(fontSize: 11),
              textAlign: pw.TextAlign.justify,
            ),

            pw.SizedBox(height: 25),
            _buildField(label: 'ASUNTO', value: subject),
            _buildField(label: 'ENTIDAD O PROPIETARIO', value: owner),
            _buildField(label: 'LUGAR', value: place),

            pw.SizedBox(height: 40),

            pw.Align(
              alignment: pw.Alignment.center,
              child: pw.Container(
                width: 180,
                height: 50,
                color: PdfColors.red,
                child: pw.Center(
                  child: pw.Text(
                    'SELLO',
                    style: pw.TextStyle(
                        color: PdfColors.white, fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ),
            ),

            pw.SizedBox(height: 40),
            pw.Center(
              child: pw.Text(
                '$place, especialidad: $specialty, $dateText',
                style: const pw.TextStyle(fontSize: 11),
              ),
            ),

            pw.SizedBox(height: 20),
            /* pw.Center(
              child: pw.Text(
                'VALIDO SOLO ORIGINAL',
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ), */

            pw.Spacer(),

            pw.Align(
              alignment: pw.Alignment.bottomLeft,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // pw.Stack(children: [

                  // ]),
                  pw.Container(
                    // color: PdfColors.blue,
                    width: 80,
                    height: 70,
                    child: pw.Image(
                      signature, /*  fit: pw.BoxFit.fitWidth */
                    ),
                   /*  decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        top: pw.BorderSide(width: 1), // grosor de la línea
                      ),
                    ), */
                  ),
                  // pw.Text(
                  //   '______________________________',
                  //   style: const pw.TextStyle(height: 1),
                  // ),
                  pw.Divider(thickness: 0.5, indent: 0, endIndent: 350, height: 1),
                  pw.SizedBox(height: 5.0),
                  pw.Text(
                    'Consejo Departamental del\nColegio de Ingenieros del Perú',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  // final dir = await getTemporaryDirectory();
  // final file = File('${dir.path}/certificado_habilidad.pdf');
  // await file.writeAsBytes(await pdf.save());
  // return file;
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}

pw.Widget _buildField({required String label, required String value}) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 4),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(label,
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
        pw.Container(
          width: double.infinity,
          height: 22,
          decoration:
              pw.BoxDecoration(border: pw.Border.all(color: PdfColors.black)),
          padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: pw.Text(value, style: const pw.TextStyle(fontSize: 10)),
        ),
      ],
    ),
  );
}
