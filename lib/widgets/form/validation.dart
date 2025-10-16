import 'package:flutter/material.dart';
String? firstNameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your full name';
  }
  if (value.length < 2) {
    return 'Name must be at least 2 characters';
  }
  return null;
}



String? emailValidator(String? value) {
  final regex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}(?:\.[a-zA-Z]{2,})*$',
  );

  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }

  if (!regex.hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
}

String? passwordValidator(String? value) {

  final regex = RegExp(

    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$%^&*()_+\-=\[\]{};:\\|,.<>/?]).{8,}$',
  );
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (!regex.hasMatch(value)) {
    return "Please enter a valid password\n(At least 8 characters, including one uppercase letter, one lowercase letter, one number, and one special character)";

  }
  return null;
}



String? confirmPasswordValidator(String? value, TextEditingController _passwordController) {
  if (value == null || value.isEmpty) {
    return 'Please confirm your password';
  }
  if (value != _passwordController.text) {
    return 'Passwords do not match';
  }
  return null;
}



void isValid(GlobalKey<FormState> _formKey, VoidCallback _submitForm) {
  if (_formKey.currentState!.validate()) {
    _submitForm();
  }
}