import 'package:flutter/material.dart';
import 'package:flutter_testing_lab/weather/weather_controller.dart';

import 'weather_model.dart';

class WeatherDisplay extends StatefulWidget {
  const WeatherDisplay({super.key});

  @override
  State<WeatherDisplay> createState() => _WeatherDisplayState();
}

class _WeatherDisplayState extends State<WeatherDisplay> {
  WeatherController _controller = WeatherController();
  Future<void> _loadWeather() async {
    // Show loading indicator بدل emit loading state
    setState(() {
      _controller.isLoading = true;
      _controller.error = null;
    });
    //sometimes return null so it crash during runtime
    try {
      final data = await _controller.fetchWeatherData(_controller.selectedCity);
      if (data == null || !data.containsKey('temperature') || !data.containsKey('city')) {
        throw Exception('Invalid data received');
      }
      setState(() {
        _controller.weatherData = WeatherData.fromJson(data);
        _controller.isLoading = false;
      });
    } catch (e) {
      setState(() {
        _controller.isLoading = false;
        _controller.error = 'Failed to load weather data for $_controller.selectedCity';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // City selection
          Row(
            children: [
              const Text('City: '),
              const SizedBox(width: 8),
              Expanded(
                /// Dropdown for city selection
                child: DropdownButton<String>(
                  value: _controller.selectedCity,
                  isExpanded: true,
                  items: _controller.cities.map((city) {
                    return DropdownMenuItem(value: city, child: Text(city));
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _controller.selectedCity = value;
                      });
                      _loadWeather();
                    }
                  },
                ),
              ),


              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _loadWeather,
                child: const Text('Refresh'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Temperature unit toggle
          Row(
            children: [
              const Text('Temperature Unit:'),
              const SizedBox(width: 10),
              ///  Switch to toggle between Celsius and Fahrenheit
              Switch(
                value: _controller.useFahrenheit,
                onChanged: (value) {
                  setState(() {
                    _controller.useFahrenheit = value;
                  });
                },
              ),
              Text(_controller.useFahrenheit ? 'Fahrenheit' : 'Celsius'),
            ],
          ),
          const SizedBox(height: 16),

          if (_controller.isLoading)
            const Center(child: CircularProgressIndicator()),
          if(_controller.error != null)
            Center(
              child: Text(
                _controller.error!,
                style: const TextStyle(color: Colors.red),
              ),
            )
          else if (_controller.weatherData != null)
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          _controller.weatherData!.icon,
                          style: const TextStyle(fontSize: 48),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _controller.weatherData!.city,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _controller.weatherData!.description,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        _controller.useFahrenheit
                            ? '${_controller.celsiusToFahrenheit(_controller.weatherData!.temperatureCelsius).toStringAsFixed(1)}°F'
                            : '${_controller.weatherData!.temperatureCelsius.toStringAsFixed(1)}°C',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildWeatherDetail(
                          'Humidity',
                          '${_controller.weatherData!.humidity}%',
                          Icons.water_drop,
                        ),
                        _buildWeatherDetail(
                          'Wind Speed',
                          '${_controller.weatherData!.windSpeed} km/h',
                          Icons.air,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          
        ],
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 32),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
