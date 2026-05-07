import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinning_fishing_app/consts/api_consts.dart';
import 'package:spinning_fishing_app/core/http_client/ai_token_interceptor.dart';
import 'package:spinning_fishing_app/core/http_client/http_client.dart';
import 'package:spinning_fishing_app/features/ai_assistant/data/ai_assistant_service.dart';
import 'package:spinning_fishing_app/features/ai_assistant/domain/ai_assistant_repository.dart';
import 'package:spinning_fishing_app/features/geo/data/geo_service.dart';
import 'package:spinning_fishing_app/features/geo/domain/repositories/geo_repository.dart';
import 'package:spinning_fishing_app/features/start_page/start_page.dart';
import 'package:spinning_fishing_app/features/weather/data/weather_service.dart';
import 'package:spinning_fishing_app/features/weather/domain/weather_repository.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late GeoService _geoService;
  late GeoRepository _geoRepository;
  late WeatherService _weatherService;
  late WeatherRepository _weatherRepository;
  late AIAssistantService _aiAssistantService;
  late AIAssistantRepository _aiAssistantRepository;

  @override
  void initState() {
    super.initState();
    _geoService = GeoServiceImpl();
    _geoRepository = GeoRepositoryImpl(geoService: _geoService);
    _weatherService = WeatherServiceImpl(DioClient(APIConsts.weatherAPI));
    _weatherRepository = WeatherRepositoryImpl(_weatherService);
    _aiAssistantService = AIAssistantServiceImpl(DioClient(APIConsts.openAIAPI, interceptor: AITokenInterceptor()));
    _aiAssistantRepository = AIAssistantRepositoryImpl(_aiAssistantService);
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _geoRepository),
        RepositoryProvider(create: (context) => _weatherRepository),
        RepositoryProvider(create: (context) => _aiAssistantRepository),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
        home: const StartPage(),
      ),
    );
  }
}
