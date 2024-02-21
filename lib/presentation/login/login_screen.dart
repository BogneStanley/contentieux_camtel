import 'dart:math';

import 'package:contentieux/core/tools/custom_extension.dart';
import 'package:contentieux/presentation/contentieux/co_screen.dart';
import 'package:contentieux/presentation/widgets/custom_button.dart';
import 'package:contentieux/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appProviderController =
        Provider.of<AppProvider>(context, listen: false);
    final appProvider = Provider.of<AppProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  50.ph,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(300),
                    child: Image.asset("assets/logo.png"),
                  ),
                  Center(
                    child: Text(
                      "!Contentieux",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  50.ph,
                  CustomTFF(
                    hintText: "Identifiant",
                    controller: name,
                  ),
                  15.ph,
                  CustomPFF(
                    hintText: "Mot de passe",
                    controller: password,
                  ),
                  50.ph,
                  CustomButton(
                    label: "Connexion",
                    loading: appProvider.loading,
                    onPressed: () async {
                      appProviderController.handleLoading(true);
                      await Future.delayed(
                          Duration(seconds: Random().nextInt(3) + 3));
                      appProviderController.handleLoading(false);

                      if (name.text.trim() == "contentieux" &&
                          password.text == "contentieux") {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return const CoScreen();
                          },
                        ));
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: IntrinsicHeight(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 35,
                                    vertical: 25,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Identifiants ou mots de passe incorrect !",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: const Color.fromARGB(
                                                255, 185, 45, 35)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                  70.ph,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
