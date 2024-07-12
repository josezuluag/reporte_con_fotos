import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/report.dart';

class PDFGenerator {
  static void generateReportPDF(Report report) {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Reporte: ${report.title}',
                style: pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 10),
            pw.Text('Fecha: ${report.date.toString()}'),
            pw.SizedBox(height: 20),
            pw.Text('Descripción:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text(report.description),
            pw.SizedBox(height: 20),
            pw.Text('Imágenes:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            for (var imagePath in report.imagePaths)
              pw.Container(
                padding: pw.EdgeInsets.symmetric(vertical: 5),
                child:
                    pw.Image(pw.MemoryImage(File(imagePath).readAsBytesSync())),
              ),
          ],
        ),
      ),
    );

    final output = File('${report.title}.pdf');
    output.writeAsBytesSync(pdf.save() as List<int>);
  }
}
