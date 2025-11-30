import 'package:flutter/material.dart';

const greenColor = Color(0xff386745); 
const cream =Color(0xffF8F6F1);

class textfieldcostom extends StatelessWidget {
  const textfieldcostom(String s, {
    super.key,
    required this.hint,
    this.obscureText = false,
  });

  final String hint;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color.fromARGB(200, 255, 255, 255)),
        filled: true,
        fillColor: const Color.fromARGB(0, 46, 90, 58),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.white, width: 1.5),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      obscureText: obscureText,
    );
  }
}
