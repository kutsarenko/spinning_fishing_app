import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinning_fishing_app/features/ai_assistant/data/models/ai_response_model.dart';
import 'package:spinning_fishing_app/features/ai_assistant/domain/ai_assistant_repository.dart';
import 'package:spinning_fishing_app/features/geo/data/models/geo_model.dart';
import 'package:spinning_fishing_app/features/geo/domain/repositories/geo_repository.dart';
import 'package:spinning_fishing_app/features/start_page/domain/blocs/bloc/start_page_bloc.dart';
import 'package:spinning_fishing_app/features/weather/data/models/weather_model.dart';
import 'package:spinning_fishing_app/features/weather/domain/weather_repository.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StartPageBloc(
        geoRepository: context.read<GeoRepository>(),
        weatherRepository: context.read<WeatherRepository>(),
        aiAssistantRepository: context.read<AIAssistantRepository>(),
      ),
      child: const _StartPageView(),
    );
  }
}

class _StartPageView extends StatefulWidget {
  const _StartPageView();

  @override
  State<_StartPageView> createState() => _StartPageViewState();
}

class _StartPageViewState extends State<_StartPageView> {
  @override
  void initState() {
    super.initState();
    context.read<StartPageBloc>().add(FetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<StartPageBloc, StartPageState>(
              builder: (context, state) {
                switch (state) {
                  case StartPageInitialState() || StartPageLoadingState():
                    return const CircularProgressIndicator.adaptive();
                  case StartPageErrorState():
                    return Text(state.error);
                  case StartPageSuccessState():
                    final GeoModel geoModel = state.geo;
                    final WeatherModel weatherModel = state.weather;
                    final AIResponseModel fishingAdvice = state.fishingAdvice;
                    return Column(
                      children: [
                        Text(
                          'lat: ${geoModel.lat}, lon: ${geoModel.lon}\ntemp: ${weatherModel.temperature}, pressure: ${weatherModel.pressure}, wind speed: ${weatherModel.windSpeed}',
                        ),
                        Text(
                          'Совет по ловле:\n- рекомендованные приманки: ${fishingAdvice.recommendedLures}\n- активность: ${fishingAdvice.activityLevel}\n- совет: ${fishingAdvice.fishindAdvice}',
                        ),
                      ],
                    );
                }
              },
            ),
            TextButton(onPressed: () => context.read<StartPageBloc>().add(FetchData()), child: const Text('Refresh')),
          ],
        ),
      ),
    );
  }
}
