part of 'geo_bloc.dart';

sealed class GeoEvent extends Equatable {
  const GeoEvent();

  @override
  List<Object> get props => [];
}

class GeoRequested extends GeoEvent {}
