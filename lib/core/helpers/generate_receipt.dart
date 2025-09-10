import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> generateReceipt({
  required String receiptNumber,
  required String date,
  required String name,
  required String dni,
  required double subtotal,
  required double igv,
  required double total,
}) async {
  print('tratando de imprimir');
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      margin: const pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Encabezado con logo y nombre
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("MiCIP",
                        style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.red,
                        )),
                    pw.SizedBox(height: 8),
                    pw.Text("Recibo N°: $receiptNumber"),
                    pw.Text("Emitido: $date"),
                  ],
                ),
                // Puedes cargar tu logo con:
                // pw.Image(pw.MemoryImage(logoBytes), width: 60),
              ],
            ),
            pw.SizedBox(height: 20),

            // Datos del cliente
            pw.Text("Nombre: $name"),
            pw.Text("DNI: $dni"),
            pw.SizedBox(height: 20),

            // Caja del total
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.red, width: 1),
                borderRadius: pw.BorderRadius.circular(4),
              ),
              child: pw.Text("Total del recibo: S/. $total",
                  style: pw.TextStyle(fontSize: 16)),
            ),
            pw.SizedBox(height: 20),

            // Descripción de lo pagado
            pw.Text("Adelanto de cuotas .......................... S/. $total"),

            pw.Spacer(),

            // Totales abajo a la derecha
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text("Sub Total (sin I.G.V.): S/. $subtotal"),
                    pw.Text("I.G.V. 18%: S/. $igv"),
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
        );
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
