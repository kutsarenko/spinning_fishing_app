import 'package:flutter/foundation.dart';

@immutable
class WeatherDTO {
  final double lat;
  final double lon;
  final int days;

  const WeatherDTO({required this.lat, required this.lon, required this.days});
}
