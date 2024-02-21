import 'package:flutter/foundation.dart';

import '../../model/contentieux.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> makePdf(List<CustomHit> contentieuxT) async {
  final pdf = pw.Document(
    title: "note-${DateTime.now().toIso8601String()}",
  );

  pdf.addPage(
    pw.MultiPage(build: (context) {
      return [
        pw.Text("Rapport du traitement de contentieux ",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10),
        pw.Table(
          border: pw.TableBorder.all(),
          children: [
            pw.TableRow(children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                  "Abonnement",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                  "Trafic",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                  "Download (Go)",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                  "Upload (Go)",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                  "Commentaire",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ),
            ]),
            for (var content in contentieuxT)
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Text(
                      content.source.abonnement,
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Text(
                      "${content.source.jrs}",
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Text(
                      "${content.source.download}",
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Text(
                      "${content.source.upload}",
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Text(
                      content.status
                          ? "Contentieux valide, calcul de prorata a envisagé"
                          : "Contentieux invalide, fiche d'incidence requise",
                    ),
                  ),
                ],
              ),
          ],
        ),
      ];
    }),
  );

  return pdf.save();
}
