import 'package:flutter/material.dart';
import 'package:flutter_testing_lab/widgets/form/text_field.dart';
import 'package:flutter_testing_lab/widgets/form/validation.dart';
//كل feature branch فيه كل كود المشروع بالكامل،
// بس إنتِ بتعدّلي فيه الجزء اللي يخص الـ feature دي فقط.

class UserRegistrationForm extends StatefulWidget {
  const UserRegistrationForm({super.key});

  @override
  State<UserRegistrationForm> createState() => _UserRegistrationFormState();
}

class _UserRegistrationFormState extends State<UserRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  bool _isLoading = false;
  String _message = '';

  Future<void> _submitForm() async {
    setState(() {
      _isLoading = true;
      _message = '';
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _message = 'Registration successful!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              label: 'Full Name',
              controller: _nameController,
              validator: (value) {
                return firstNameValidator(value);
              },
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              hint: "habiba@gmail.com",
              validator: (value) {
                return emailValidator(value);
              },
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Password',
              keyboardType: TextInputType.visiblePassword,
              controller: _passwordController,
              helper: "At least 8 characters with numbers and symbols",
              isPassword: true,
              validator: (value) {
                return passwordValidator(value);
              },
            ),

            const SizedBox(height: 16),
            CustomTextField(
              label: 'Confirm Password',
              keyboardType: TextInputType.visiblePassword,
              controller: _confirmPasswordController,
              isPassword: true,
              validator: (value) {
                return confirmPasswordValidator(value, _passwordController);
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                //logic
               isValid(_formKey, _submitForm);
              },
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Register'),
            ),



            if (_message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  _message,
                  style: TextStyle(
                    color: _message.contains('successful')
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
