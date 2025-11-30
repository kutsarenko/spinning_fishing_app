part of 'start_page_bloc.dart';

sealed class StartPageState extends Equatable {
  const StartPageState();

  @override
  List<Object> get props => [];
}

final class StartPageInitialState extends StartPageState {}

final class StartPageLoadingState extends StartPageState {}

final class StartPageSuccessState extends StartPageState {
  final GeoModel geo;
  final WeatherModel weather;

  const StartPageSuccessState({required this.geo, required this.weather});

  @override
  List<Object> get props => [...super.props, geo, weather];
}

final class StartPageErrorState extends StartPageState {
  final String error;

  const StartPageErrorState(this.error);

  @override
  List<Object> get props => [...super.props, error];
}
