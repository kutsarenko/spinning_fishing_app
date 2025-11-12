part of 'geo_bloc.dart';

sealed class GeoState extends Equatable {
  const GeoState();

  @override
  List<Object> get props => [];
}

final class GeoInitialState extends GeoState {}

final class GeoLoadingState extends GeoState {}

final class GeoSuccessState extends GeoState {
  final GeoModel geoModel;

  const GeoSuccessState(this.geoModel);

  @override
  List<Object> get props => [geoModel, ...super.props];
}

final class GeoErrorState extends GeoState {
  final String error;

  const GeoErrorState(this.error);

  @override
  List<Object> get props => [error, ...super.props];
}
