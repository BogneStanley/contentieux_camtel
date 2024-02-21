import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../api/elasticsearch_api.dart';
import '../model/contentieux.dart';
import 'package:pdf/widgets.dart' as pw;

class AppProvider extends ChangeNotifier {
  List<Hit> contentieux = [];
  List<Hit> selectedContentieux = [];
  List<CustomHit> contentieuxTraitee = [];
  ElasticsearchApi api = ElasticsearchApi();
  bool contentieuxIsLoading = false;
  bool loading = false;

  handleContentieux(List<Hit> newContentieux) {
    contentieux = newContentieux;
    notifyListeners();
  }

  handleSelectedContentieux(List<Hit> newContentieux) {
    selectedContentieux = newContentieux;
    notifyListeners();
  }

  handelContentieuxIsLoading(bool newValue) {
    contentieuxIsLoading = newValue;
    notifyListeners();
  }

  handleLoading(bool newValue) {
    loading = newValue;
    notifyListeners();
  }

  clearContentieux() async {
    handelContentieuxIsLoading(true);
    await Future.delayed(Duration(seconds: (Random().nextInt(3) + 1)));
    handleContentieux([]);
    handleSelectedContentieux([]);
    handelContentieuxIsLoading(false);
  }

  CustomHit treatement(Hit hit) {
    bool status = false;

    if (hit.source.jrs < 9) {
      status = true;
    } else if (hit.source.jrs >= 9 && hit.source.jrs < 15) {
      if ((hit.source.upload + hit.source.download) < 400) {
        status = true;
      }
    } else if (hit.source.jrs >= 15 && hit.source.jrs < 20) {
      if ((hit.source.upload + hit.source.download) < 10) {
        status = true;
      }
    }

    return CustomHit(source: hit.source, status: status);
  }

  handleContentieuxTraiter(List<CustomHit> newValue) {
    contentieuxTraitee = newValue;
    notifyListeners();
  }

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

  updateContentieux(CustomHit customHit, bool status) {
    List<CustomHit> updated = contentieuxTraitee.map<CustomHit>((element) {
      if (element.source.codeclient == customHit.source.codeclient) {
        return element..status = status;
      }
      return element;
    }).toList();

    handleContentieuxTraiter(updated);

    notifyListeners();
  }

  treatmentContentieux() {
    contentieuxTraitee.clear();
    selectedContentieux.forEach((element) {
      contentieuxTraitee.add(treatement(element));
    });

    notifyListeners();
  }

  getContentieux() async {
    handelContentieuxIsLoading(true);
    var _contentieux = await api.getContentieux();
    if (!_contentieux.keys.contains("error")) {
      handleContentieux(Contentieux.fromMap(_contentieux["hits"]).hits);
      handleSelectedContentieux(Contentieux.fromMap(_contentieux["hits"]).hits);
    }
    handelContentieuxIsLoading(false);
  }
}
