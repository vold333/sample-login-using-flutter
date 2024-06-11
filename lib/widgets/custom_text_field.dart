import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final Widget? suffixIcon;

  CustomTextField({
    required this.label,
    this.isPassword = false,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.validator,
    this.maxLength,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword ? obscureText : false,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
