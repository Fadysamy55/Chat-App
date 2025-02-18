import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  final Function(String)? onChanged;
  final String? hintText;
  final bool obscureText;

  const CustomFormTextField({
    Key? key,
    this.onChanged,
    this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText, // Now uses the correct parameter
      validator: (data) {
        if (data == null || data.isEmpty) {
          return 'Field is required';
        }
        return null; // Return null if the input is valid
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
