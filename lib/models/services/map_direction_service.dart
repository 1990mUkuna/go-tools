import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:news_app/models/core/directions_model.dart';

class DirectionsServices {
  static const _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json';
  final Dio _dio;
  DirectionsServices({Dio dio}) : _dio = dio ?? Dio();

  Future<Directions> getDirections({
    @required LatLng origin,
    @required LatLng destination,
  }) async {
    final response = await _dio.get(_baseUrl, queryParameters: {
      'origin': '${origin.latitude}, ${origin.longitude}',
      'destination': '${destination.latitude}, ${destination.longitude}',
      'key': 'AIzaSyAPbgXNIN8zS8J_Usdf7FI3Gp8zPP0y8HA',
    });

    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
  }
}
