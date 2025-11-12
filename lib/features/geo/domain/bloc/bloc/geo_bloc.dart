import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinning_fishing_app/features/geo/data/models/geo_model.dart';
import 'package:spinning_fishing_app/features/geo/domain/repositories/geo_repository.dart';

part 'geo_event.dart';
part 'geo_state.dart';

class GeoBloc extends Bloc<GeoEvent, GeoState> {
  final GeoRepository _geoRepository;
  GeoBloc({required GeoRepository geoRepository}) : _geoRepository = geoRepository, super(GeoInitialState()) {
    on<GeoRequested>(_onGeoRequestedEvent);
  }

  Future<void> _onGeoRequestedEvent(GeoRequested event, Emitter<GeoState> emit) async {
    try {
      emit(GeoLoadingState());

      final GeoModel geoModel = await _geoRepository.getUserGeo();
      emit(GeoSuccessState(geoModel));
    } catch (e) {
      emit(GeoErrorState(e.toString()));
    }
  }
}
