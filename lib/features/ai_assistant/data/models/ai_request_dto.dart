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
Тебе нужно, учитывая данные по локации и погоде, дать полезный совет рыбаку для ловли хищной рыбы на спиннинг.
Верни ответ строго в JSON формате.

Поля:
recommended_lures -> массив строк (не более трё приманок)
activity_level -> низкая|средняя|высокая
fishing_advice -> краткий совет

Данные:
Локация: ${geo.lat}, ${geo.lon}
Температура: ${weather.temperature}
Давление: ${weather.pressure}
Ветер: ${weather.windSpeed}
""",
            },
          ],
        },
      ],
    };
  }
}
