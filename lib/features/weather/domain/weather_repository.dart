import 'package:spinning_fishing_app/features/weather/data/models/weather_dto.dart';
import 'package:spinning_fishing_app/features/weather/data/models/weather_model.dart';
import 'package:spinning_fishing_app/features/weather/data/weather_service.dart';

abstract interface class WeatherRepository {
  Future<WeatherModel> getTodayWeather(double lat, double lon);
}

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherService _weatherService;

  WeatherRepositoryImpl(WeatherService weatherService) : _weatherService = weatherService;

  @override
  Future<WeatherModel> getTodayWeather(double lat, double lon) async {
    try {
      final weatherDTO = WeatherDTO(lat: lat, lon: lon, days: 1);
      final List<WeatherModel> weatherList = await _weatherService.getWeather(weatherDTO);
      if (weatherList.isEmpty) {
        throw Exception();
      }
      return weatherList.first;
    } catch (_) {
      rethrow;
    }
  }
}
