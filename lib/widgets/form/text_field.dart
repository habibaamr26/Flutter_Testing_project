import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final String? helper;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  const CustomTextField({
    required this.keyboardType,
    Key? key,
    required this.label,
    this.hint,
    this.helper,
    this.isPassword = false,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: TextInputType.text,
      validator: validator,
      decoration: InputDecoration(
        helperText: helper,
        border: OutlineInputBorder(),
        labelText: label,
        hintText: hint,
        hintStyle:  TextStyle(color: Colors.grey,fontSize:12),
      ),
    );
  }
}