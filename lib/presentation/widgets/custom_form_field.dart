import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTFF extends StatelessWidget {
  const CustomTFF({
    super.key,
    required this.hintText,
    this.enable = true,
    required this.controller,
  });
  final String hintText;
  final bool enable;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: TextFormField(
        enabled: enable,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          border: InputBorder.none,
          hintText: hintText,
          fillColor: const Color.fromRGBO(238, 248, 255, 1),
          hintStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}

class CustomPFF extends StatefulWidget {
  const CustomPFF({
    super.key,
    required this.hintText,
    required this.controller,
  });
  final String hintText;
  final TextEditingController controller;

  @override
  State<CustomPFF> createState() => _CustomPFFState();
}

class _CustomPFFState extends State<CustomPFF> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: TextFormField(
        obscureText: !show,
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          border: InputBorder.none,
          hintText: widget.hintText,
          fillColor: const Color.fromRGBO(238, 248, 255, 1),
          hintStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
          contentPadding: const EdgeInsets.all(20),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                show = !show;
              });
            },
            icon: Icon(
              show ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
      ),
    );
  }
}
