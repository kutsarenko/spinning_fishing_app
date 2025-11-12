import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinning_fishing_app/features/geo/data/models/geo_model.dart';
import 'package:spinning_fishing_app/features/geo/domain/bloc/bloc/geo_bloc.dart';
import 'package:spinning_fishing_app/features/geo/domain/repositories/geo_repository.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GeoBloc(geoRepository: context.read<GeoRepository>()),
      child: const _MainScreenView(),
    );
  }
}

class _MainScreenView extends StatefulWidget {
  const _MainScreenView();

  @override
  State<_MainScreenView> createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<_MainScreenView> {
  @override
  void initState() {
    super.initState();
    context.read<GeoBloc>().add(GeoRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<GeoBloc, GeoState>(
              builder: (context, state) {
                switch (state) {
                  case GeoInitialState() || GeoLoadingState():
                    return const CircularProgressIndicator.adaptive();
                  case GeoErrorState():
                    return Text(state.error);
                  case GeoSuccessState():
                    final GeoModel geoModel = state.geoModel;
                    return Text('lat: ${geoModel.lat}\nlon: ${geoModel.lon}');
                }
              },
            ),
            TextButton(onPressed: () => context.read<GeoBloc>().add(GeoRequested()), child: const Text('Refresh')),
          ],
        ),
      ),
    );
  }
}
