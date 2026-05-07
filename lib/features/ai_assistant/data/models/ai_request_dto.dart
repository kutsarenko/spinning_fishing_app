import 'package:spinning_fishing_app/features/geo/data/models/geo_model.dart';
import 'package:spinning_fishing_app/features/weather/data/models/weather_model.dart';

class AIRequestDTO {
  final GeoModel geo;
  final WeatherModel weather;

  const AIRequestDTO({required this.geo, required this.weather});

  Map<String, dynamic> toJson() {
    return {
      "contents": [
        {
          "parts": [
            {
              "text":
                  """
Ты — эксперт по спиннинговой ловле. 
Отвечай ТОЛЬКО в валидном JSON следующей структуры:
{
  "recommended_lures": ["пример1", "пример2"],
  "activity_level": "низкая|средняя|высокая",
  "fishing_advice": "краткий совет"
}
Локация: ${geo.lat}, ${geo.lon}. Температура: ${weather.temperature}, давление: ${weather.pressure}, ветер: ${weather.windSpeed}.
""",
            },
          ],
        },
      ],
    };
  }
}
