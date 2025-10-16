import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/form/user_registration_form.dart';
import 'package:flutter_testing_lab/widgets/form/validation.dart';
import 'package:flutter/material.dart';

void main() {
  test('firstNameValidator returns null for valid name', () {
    expect(firstNameValidator('Habiba'), null);
  });
  test('emailValidator returns null for valid email', () {
    expect(emailValidator('habiba@gmail.com'), null);
  });

  test('emailValidator returns error for invalid email', () {
    expect(emailValidator('a@'), 'Please enter a valid email');
  });

  test('passwordValidator returns null for valid password', () {
    expect(passwordValidator('Password1@'), null);
  });
  test('passwordValidator returns error for invalid password', () {
    expect(
      passwordValidator('pass'),
      'Please enter a valid password\n(At least 8 characters, including one uppercase letter, one lowercase letter, one number, and one special character)',
    );
  });

  test('confirmPasswordValidator returns null for matching passwords', () {
    final passwordController = TextEditingController(text: 'Password1@');
    expect(confirmPasswordValidator('Password1@', passwordController), null);
  });


  group('UserRegistrationForm Widget Tests', () {
    testWidgets('shows validation errors when fields are empty', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: UserRegistrationForm()),
        ),
      );

      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Please'),findsWidgets);
    });

    testWidgets('shows error for invalid email format', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: UserRegistrationForm()),
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(1), 'invalid_email');
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.textContaining('valid email'), findsOneWidget);
    });

    testWidgets('shows error if passwords do not match', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: UserRegistrationForm()),
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(2), 'Password@123');
      await tester.enterText(find.byType(TextFormField).at(3), 'Mismatch@123');

      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Passwords do not match'), findsOneWidget);
    });

    testWidgets('shows success message when form is valid', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: UserRegistrationForm()),
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'Habiba Amr');
      await tester.enterText(find.byType(TextFormField).at(1), 'habiba@gmail.com');
      await tester.enterText(find.byType(TextFormField).at(2), 'Password@123');
      await tester.enterText(find.byType(TextFormField).at(3), 'Password@123');

      await tester.tap(find.text('Register'));
      await tester.pump(const Duration(seconds: 2)); // simulate loading
      await tester.pumpAndSettle();

      expect(find.text('Registration successful!'), findsOneWidget);
    });
  });
}
