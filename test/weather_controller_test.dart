

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/weather/weather_controller.dart';

void main(){


  test("test to convert from celsius To Fahrenheit", (){
    WeatherController controller = WeatherController();
    double fahrenheit = controller.celsiusToFahrenheit(27);
    expect(fahrenheit, 80.6);
  });

  test("test to convert from fahrenheit To Celsius", (){
    WeatherController controller = WeatherController();
    double celsius = controller.fahrenheitToCelsius(80);
    expect(celsius, 26.666666666666668);
  });

  test("test to choose invalid city", () async {
    WeatherController controller = WeatherController();
      final data =await controller.fetchWeatherData ("Invalid City");
    expect(data, null);

  });


  test("should return correct weather data for London", () async {
    WeatherController controller = WeatherController();
    final data =await controller.fetchWeatherData ("London");
    // will fail sometimes because of simulated malformed data هتنجح مره من اربعه
    final response = {
      'city': 'London',
      'temperature': 15.0,
      'description': 'Rainy',
      'humidity': 85,
      'windSpeed': 8.5,
      'icon': '🌧️',
    };
    expect(data, containsPair('city', 'London'));
  });
}