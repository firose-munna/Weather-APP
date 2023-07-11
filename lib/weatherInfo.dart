import 'package:intl/intl.dart';

class Weather{
  final String name, weatherDescription, weatherIcon, updatedTime, temperature, minTemperature, maxTemperature;

  Weather({required this.name, required this.weatherDescription,
    required this.weatherIcon, required this.updatedTime, required this.temperature,
    required this.minTemperature, required this.maxTemperature});

  factory Weather.toJson(Map<String, dynamic> e){
    final currentTime = DateTime.now();
    final updatedTime = DateFormat('h:mm a').format(currentTime);

    final temperature = (e['main']['temp'] - 273.15).toStringAsFixed(0);
    final minTemperature = (e['main']['temp_min'] - 273.15).toStringAsFixed(0);
    final maxTemperature = (e['main']['temp_max'] - 273.15).toStringAsFixed(0);
    return Weather(
        name: e['name'],
        weatherDescription: e['weather'][0]['main'],
        weatherIcon: e['weather'][0]['icon'],

        temperature: temperature,
        minTemperature: minTemperature,
        maxTemperature: maxTemperature,
        updatedTime: updatedTime
    );

  }
}
