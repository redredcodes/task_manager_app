import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key,
    required this.hintText,
    this.labelText,
    this.controller,
    this.keyboardType,
    required this.obscureText,
    this.validator,
    this.prefixIcon,
    this.suffixIcon});

  final String hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final Icon? prefixIcon;
  final Icon? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: hintText,
            prefix: prefixIcon,
            suffixIcon: suffixIcon,
            ),
      ),
    );
  }
}
