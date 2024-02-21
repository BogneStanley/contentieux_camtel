import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.bg = const Color.fromRGBO(80, 123, 245, 1),
    this.loading = false,
  });
  final void Function()? onPressed;
  final String label;
  final Color bg;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: const MaterialStatePropertyAll(
          Size.fromHeight(
            60,
          ),
        ),
        elevation: const MaterialStatePropertyAll(0),
        shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(
          bg,
        ),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(
            vertical: 10,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: loading
            ? const Center(
                child: SizedBox(
                  width: 25,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
