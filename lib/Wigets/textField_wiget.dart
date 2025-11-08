import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  final String text;


  const Textfield({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 53, 69, 77),
        filled: true,
        hintText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
