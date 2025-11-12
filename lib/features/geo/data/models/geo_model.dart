import 'package:equatable/equatable.dart';

class GeoModel extends Equatable {
  final double lat;
  final double lon;

  const GeoModel({required this.lat, required this.lon});

  @override
  List<Object?> get props => [lat, lon];
}
