import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';


Future<void> generatePdfToShare({
  required String receiptNumber,
  required String date,
  required String name,
  required String dni,
  required double subtotal,
  required double igv,
  required double total,
  required String typePay,
}) async {
  final pdf = pw.Document();

  pdf.addPage(pw.Page(
    margin: const pw.EdgeInsets.all(32),
    build: (pw.Context context) {
      return pw.Stack(
        children: [
          pw.Center(
              child: pw.Opacity(
            opacity: 0.08,
            child: pw.Text('COLEGIO DE INGENIEROS DEL PERÚ',
                style: const pw.TextStyle(
                  color: PdfColors.black,
                  fontSize: 45.0,
                )), // Negro con 10% opacidad)),
          )),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                children: [
                  // pw.Container(
                  //   width: 80,
                  //   height: 80,
                  //   child: pw.Image(logo, fit: pw.BoxFit.cover),
                  // ),
                  // pw.SizedBox(width: 8.0),
                  pw.Text("MiCIP",
                      style: pw.TextStyle(
                        fontSize: 30,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.red,
                      )),
                ],
              ),

              pw.SizedBox(height: 15.0),
              pw.Text("Recibo N°: $receiptNumber"),
              pw.SizedBox(height: 15.0),
              pw.Text("Emitido: $date"),
              // pw.Image(pw.MemoryImage(logoBytes), width: 60),
              pw.SizedBox(height: 15.0),
              pw.Text("Nombre: $name"),
              pw.SizedBox(height: 15.0),
              pw.Text("DNI: $dni"),
              pw.SizedBox(height: 15.0),

              // Caja del total
              pw.Container(
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.red, width: 1),
                  borderRadius: pw.BorderRadius.circular(4),
                ),
                child: pw.Text("Total del recibo: S/. $total",
                    style: const pw.TextStyle(fontSize: 16.0)),
              ),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 20),
              // Descripción de lo pagado
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(typePay),
                    pw.Text("$total"),
                  ]),

              pw.Spacer(),

              // Totales abajo a la derecha
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                    pw.Text('Consejo Departamental de Lambayeque'),
                    pw.Text('R.U.C: 20138086438'),
                  ]),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text("Sub Total (sin I.G.V.): S/. $subtotal"),
                      pw.SizedBox(height: 10.0),
                      pw.Text("I.G.V. 18%: S/. ${igv.toStringAsPrecision(2)}"),
                      pw.SizedBox(height: 10.0),
                      pw.Text(
                        "Total recibo: S/. $total",
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.red),
                      ),
                    ],
                  )
                ],
              ),
            ],
          )
        ],
      );
    },
  ));

 await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
