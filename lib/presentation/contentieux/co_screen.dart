import 'dart:math';

import 'package:contentieux/core/tools/custom_extension.dart';
import 'package:contentieux/model/contentieux.dart';
import 'package:contentieux/presentation/traitement/traitement_result_screen.dart';
import 'package:contentieux/presentation/widgets/custom_button.dart';
import 'package:contentieux/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_form_field.dart';

class CoScreen extends StatefulWidget {
  const CoScreen({super.key});

  @override
  State<CoScreen> createState() => _CoScreenState();
}

class _CoScreenState extends State<CoScreen> {
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
                GestureDetector(
                  onTap: () async {
                    var selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2023),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2024),
                    );
                    if (selectedDate == null) {
                      return;
                    }
                    selectMonth.text =
                        "${selectedDate.month}/${selectedDate.year}";
                    if (selectedDate.year == 2023 && selectedDate.month == 6) {
                      appProviderController.getContentieux();
                    } else {
                      appProviderController.clearContentieux();
                    }
                  },
                  child: CustomTFF(
                    hintText: "Mois du contentieux",
                    enable: false,
                    controller: selectMonth,
                  ),
                ),
                30.ph,
                Row(
                  children: [
                    Expanded(
                      child: CustomTFF(
                        hintText: "Numero Client",
                        controller: codeClient,
                      ),
                    ),
                    5.pw,
                    IconButton(
                      onPressed: () {},
                      icon: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(Icons.search),
                      ),
                      color: Colors.white,
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(80, 123, 245, 1)),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                30.ph,
                Expanded(
                  child: !appProvider.contentieuxIsLoading
                      ? (appProvider.selectedContentieux.isNotEmpty
                          ? ListView.builder(
                              itemCount: appProvider.selectedContentieux.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 0,
                                  color: const Color.fromRGBO(238, 248, 255, 1),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 14, right: 8, top: 8, bottom: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            appProvider
                                                .selectedContentieux[index]
                                                .source
                                                .abonnement,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Padding(
                                            padding: EdgeInsets.all(6.0),
                                            child: Icon(Icons.close),
                                          ),
                                          color: Colors.white,
                                          style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Color.fromRGBO(
                                                        245, 80, 120, 1)),
                                            shape: MaterialStatePropertyAll(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15),
                                                ),
                                              ),
                                            ),
                                          ),
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
                  label: "Traiter",
                  loading: appProvider.loading,
                  onPressed: () async {
                    appProviderController.handleLoading(true);
                    appProviderController.treatmentContentieux();
                    await Future.delayed(
                      Duration(
                        seconds: Random().nextInt(4) + 4,
                      ),
                    );
                    appProviderController.handleLoading(false);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return TraitementResultScreen();
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
