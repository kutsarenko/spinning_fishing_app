import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinning_fishing_app/features/geo/data/geo_service.dart';
import 'package:spinning_fishing_app/features/geo/domain/repositories/geo_repository.dart';
import 'package:spinning_fishing_app/features/main/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
