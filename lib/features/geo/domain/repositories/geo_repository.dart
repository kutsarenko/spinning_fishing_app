import 'package:spinning_fishing_app/features/geo/data/geo_service.dart';
import 'package:spinning_fishing_app/features/geo/data/models/geo_model.dart';

abstract interface class GeoRepository {
  Future<GeoModel> getUserGeo();
}

class GeoRepositoryImpl implements GeoRepository {
  final GeoService _geoService;

  GeoRepositoryImpl({required GeoService geoService}) : _geoService = geoService;
  @override
  Future<GeoModel> getUserGeo() async {
    try {
      return await _geoService.getUserGeo();
    } catch (_) {
      rethrow;
    }
  }
}
