import 'package:flutter/material.dart';

class TextfieldCustom extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool? obscureText;
  const TextfieldCustom({
    super.key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
      child: TextField(
        textAlign: TextAlign.center,
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          label: Text(labelText),
          labelStyle: TextStyle(color: Colors.white),
          focusColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
        obscureText: obscureText ?? false,
      ),
    );
  }
}
