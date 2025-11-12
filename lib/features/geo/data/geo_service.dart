import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spinning_fishing_app/features/geo/data/models/geo_model.dart';

abstract interface class GeoService {
  Future<GeoModel> getUserGeo();
}

class GeoServiceImpl implements GeoService {
  @override
  Future<GeoModel> getUserGeo() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied, we cannot request permissions.');
      }
      final Position position = await Geolocator.getCurrentPosition();

      return GeoModel(lat: position.latitude, lon: position.longitude);
    } catch (e, stackTrace) {
      debugPrint('Getting user geo error: $e\n$stackTrace');
      rethrow;
    }
  }
}
