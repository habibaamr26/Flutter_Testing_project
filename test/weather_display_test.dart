import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/weather/weather_display.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets("test Dropdown for city selection widget", (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: WeatherDisplay())),
    );
    await tester.pumpAndSettle();
    final dropdownFinder = find.byType(DropdownButton<String>);
    expect(dropdownFinder, findsOneWidget);
    await tester.tap(dropdownFinder);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tokyo').last);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.text('Tokyo'), findsWidgets);
  });

  testWidgets("test Switch to toggle between Celsius and Fahrenheit ", (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: WeatherDisplay())),
    );

    await tester.pumpAndSettle();
    final switchFinder = find.byType(Switch);
    expect(switchFinder, findsOneWidget);
    await tester.tap(switchFinder);
    await tester.pumpAndSettle();
    expect(find.text('Fahrenheit'), findsWidgets);
  });
}
