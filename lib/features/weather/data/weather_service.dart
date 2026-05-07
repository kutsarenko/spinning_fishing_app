import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spinning_fishing_app/core/http_client/http_client.dart';
import 'package:spinning_fishing_app/features/weather/data/models/weather_dto.dart';
import 'package:spinning_fishing_app/features/weather/data/models/weather_model.dart';

abstract interface class WeatherService {
  Future<List<WeatherModel>> getWeather(WeatherDTO weatherDTO);
}

class WeatherServiceImpl implements WeatherService {
  final DioClient _dioClient;

  const WeatherServiceImpl(DioClient dioClient) : _dioClient = dioClient;
  @override
  Future<List<WeatherModel>> getWeather(WeatherDTO weatherDTO) async {
    const String path = 'data/2.5/forecast';
    try {
      final Map<String, dynamic> querryParams = {
        'lat': weatherDTO.lat,
        'lon': weatherDTO.lon,
        'cnt': weatherDTO.days,
        'appid': dotenv.get('WEATHER_API_KEY'),
      };
      final response = await _dioClient.getDio.get(path, queryParameters: querryParams);

      return WeatherModel.fromJsonList(response.data['list'] as List<dynamic>);
    } catch (e, stackTrace) {
      debugPrint('Getting weather error: $e\n$stackTrace');
      rethrow;
    }
  }
}
