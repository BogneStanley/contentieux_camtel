import 'dart:math';

import 'package:contentieux/core/tools/custom_extension.dart';
import 'package:contentieux/core/utils/helpers.dart';
import 'package:contentieux/model/contentieux.dart';
import 'package:contentieux/presentation/widgets/custom_button.dart';
import 'package:contentieux/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:printing/printing.dart';

import '../widgets/custom_form_field.dart';

class TraitementResultScreen extends StatefulWidget {
  const TraitementResultScreen({super.key});

  @override
  State<TraitementResultScreen> createState() => _TraitementResultScreenState();
}

class _TraitementResultScreenState extends State<TraitementResultScreen> {
  TextEditingController selectMonth = TextEditingController();
  TextEditingController codeClient = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final appProviderController =
        Provider.of<AppProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back)),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(300),
                      child: Image.asset(
                        "assets/logo.png",
                        width: 50,
                      ),
                    ),
                    Text(
                      "!Contentieux",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    )
                  ],
                ),
                30.ph,
                CustomTFF(
                  hintText: "Rechercher...",
                  controller: selectMonth,
                ),
                30.ph,
                Expanded(
                  child: !appProvider.contentieuxIsLoading
                      ? (appProvider.contentieuxTraitee.isNotEmpty
                          ? ListView.builder(
                              itemCount: appProvider.contentieuxTraitee.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 0,
                                  color: const Color.fromRGBO(238, 248, 255, 1),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 14, right: 8, top: 8, bottom: 8),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                appProvider
                                                    .contentieuxTraitee[index]
                                                    .source
                                                    .abonnement,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Dialog(
                                                      child: IntrinsicHeight(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 35,
                                                            vertical: 25,
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                appProvider
                                                                    .contentieuxTraitee[
                                                                        index]
                                                                    .source
                                                                    .abonnement,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              const Divider(),
                                                              Text.rich(
                                                                TextSpan(
                                                                  children: [
                                                                    const TextSpan(
                                                                      text:
                                                                          "Trafic: ",
                                                                    ),
                                                                    TextSpan(
                                                                        text:
                                                                            "${appProvider.contentieuxTraitee[index].source.jrs} Jours")
                                                                  ],
                                                                ),
                                                              ),
                                                              5.ph,
                                                              Text.rich(
                                                                TextSpan(
                                                                  children: [
                                                                    const TextSpan(
                                                                      text:
                                                                          "Upload: ",
                                                                    ),
                                                                    TextSpan(
                                                                        text:
                                                                            "${appProvider.contentieuxTraitee[index].source.upload} Go")
                                                                  ],
                                                                ),
                                                              ),
                                                              5.ph,
                                                              Text.rich(
                                                                TextSpan(
                                                                  children: [
                                                                    const TextSpan(
                                                                      text:
                                                                          "Download: ",
                                                                    ),
                                                                    TextSpan(
                                                                        text:
                                                                            "${appProvider.contentieuxTraitee[index].source.download} Go")
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              icon: const Padding(
                                                padding: EdgeInsets.all(6.0),
                                                child: Icon(
                                                    Icons.visibility_outlined),
                                              ),
                                              color: Colors.white,
                                              style: const ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Color.fromRGBO(
                                                            80, 123, 245, 1)),
                                                shape: MaterialStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(15),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CustomButton(
                                                label: "A rejeter",
                                                onPressed: () {
                                                  appProviderController
                                                      .updateContentieux(
                                                          appProvider
                                                                  .contentieuxTraitee[
                                                              index],
                                                          false);
                                                },
                                                bg: !appProvider
                                                        .contentieuxTraitee[
                                                            index]
                                                        .status
                                                    ? const Color.fromRGBO(
                                                        245,
                                                        85,
                                                        20,
                                                        1,
                                                      )
                                                    : const Color.fromRGBO(
                                                        208,
                                                        208,
                                                        208,
                                                        1,
                                                      ),
                                              ),
                                            ),
                                            7.pw,
                                            Expanded(
                                              child: CustomButton(
                                                label: "Acceptable",
                                                onPressed: () {
                                                  appProviderController
                                                      .updateContentieux(
                                                          appProvider
                                                                  .contentieuxTraitee[
                                                              index],
                                                          true);
                                                },
                                                bg: appProvider
                                                        .contentieuxTraitee[
                                                            index]
                                                        .status
                                                    ? const Color.fromRGBO(
                                                        80,
                                                        245,
                                                        97,
                                                        1,
                                                      )
                                                    : const Color.fromRGBO(
                                                        208,
                                                        208,
                                                        208,
                                                        1,
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                "Aucun Contentieux",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black38,
                                ),
                              ),
                            ))
                      : const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(80, 123, 245, 1),
                          ),
                        ),
                ),
                CustomButton(
                  label: "Générer un rapport",
                  loading: appProvider.loading,
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return PdfPreviewPage(
                          hits: appProvider.contentieuxTraitee,
                        );
                      },
                    ));
                  },
                ),
                20.ph,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PdfPreviewPage extends StatelessWidget {
  final List<CustomHit> hits;
  const PdfPreviewPage({Key? key, required this.hits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: PdfPreview(
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        build: (context) => makePdf(hits),
      ),
    );
  }
}
