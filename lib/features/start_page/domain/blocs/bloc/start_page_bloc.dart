import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinning_fishing_app/features/ai_assistant/data/models/ai_request_dto.dart';
import 'package:spinning_fishing_app/features/ai_assistant/data/models/ai_response_model.dart';
import 'package:spinning_fishing_app/features/ai_assistant/domain/ai_assistant_repository.dart';
import 'package:spinning_fishing_app/features/geo/data/models/geo_model.dart';
import 'package:spinning_fishing_app/features/geo/domain/repositories/geo_repository.dart';
import 'package:spinning_fishing_app/features/weather/data/models/weather_model.dart';
import 'package:spinning_fishing_app/features/weather/domain/weather_repository.dart';

part 'start_page_event.dart';
part 'start_page_state.dart';

class StartPageBloc extends Bloc<StartPageEvent, StartPageState> {
  final GeoRepository _geoRepository;
  final WeatherRepository _weatherRepository;
  final AIAssistantRepository _aiAssistantRepository;
  StartPageBloc({
    required GeoRepository geoRepository,
    required WeatherRepository weatherRepository,
    required AIAssistantRepository aiAssistantRepository,
  }) : _geoRepository = geoRepository,
       _weatherRepository = weatherRepository,
       _aiAssistantRepository = aiAssistantRepository,
       super(StartPageInitialState()) {
    on<FetchData>(_fetchData);
  }

  Future<void> _fetchData(FetchData event, Emitter<StartPageState> emit) async {
    emit(StartPageLoadingState());
    try {
      final GeoModel geo = await _geoRepository.getUserGeo();
      final WeatherModel weather = await _weatherRepository.getTodayWeather(geo.lat, geo.lon);
      final AIRequestDTO aiRequestDTO = AIRequestDTO(geo: geo, weather: weather);
      final AIResponseModel fishingAdvice = await _aiAssistantRepository.getFishingAdvice(aiRequestDTO);
      emit(StartPageSuccessState(geo: geo, weather: weather, fishingAdvice: fishingAdvice));
    } catch (e) {
      emit(StartPageErrorState(e.toString()));
    }
  }
}
