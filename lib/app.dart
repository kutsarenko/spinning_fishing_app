import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinning_fishing_app/features/geo/data/geo_service.dart';
import 'package:spinning_fishing_app/features/geo/domain/repositories/geo_repository.dart';
import 'package:spinning_fishing_app/features/main/main_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late GeoService geoService;
  late GeoRepository geoRepository;
  @override
  void initState() {
    super.initState();
    geoService = GeoServiceImpl();
    geoRepository = GeoRepositoryImpl(geoService: geoService);
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => geoRepository)],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
        home: const MainScreen(),
      ),
    );
  }
}
