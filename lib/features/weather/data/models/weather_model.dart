import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum WeatherPrecipitationType { rain, snow, none }

@immutable
class WeatherModel extends Equatable {
  final double temperature;
  final int pressure;
  final double windSpeed;

  const WeatherModel({required this.temperature, required this.pressure, required this.windSpeed});

  factory WeatherModel._fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: json['main']['temp'] as double,
      pressure: json['main']['pressure'] as int,
      windSpeed: json['wind']['speed'],
    );
  }

  static List<WeatherModel> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map((json) => WeatherModel._fromJson(json as Map<String, dynamic>)).toList();

  @override
  List<Object?> get props => [temperature, pressure, windSpeed];
}
