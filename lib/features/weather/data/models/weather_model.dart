import 'package:equatable/equatable.dart';

enum WeatherPrecipitationType { rain, snow, none }

class WeatherModel extends Equatable {
  final double temperature;
  final double pressure;
  final WeatherPrecipitationType precipitationType;
  final String windDirection;
  final double windSpeed;

  const WeatherModel({
    required this.temperature,
    required this.pressure,
    required this.precipitationType,
    required this.windDirection,
    required this.windSpeed,
  });

  @override
  List<Object?> get props => [temperature, pressure, precipitationType, windDirection, windSpeed];
}
