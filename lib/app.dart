import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinning_fishing_app/core/api_consts.dart';
import 'package:spinning_fishing_app/core/http_client.dart';
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

  @override
  void initState() {
    super.initState();
    _geoService = GeoServiceImpl();
    _geoRepository = GeoRepositoryImpl(geoService: _geoService);
    _weatherService = WeatherServiceImpl(DioClient(APIConsts.weatherAPI));
    _weatherRepository = WeatherRepositoryImpl(_weatherService);
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _geoRepository),
        RepositoryProvider(create: (context) => _weatherRepository),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
        home: const StartPage(),
      ),
    );
  }
}
