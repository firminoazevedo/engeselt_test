import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalModel {
  LatLng? latLng;
  String? description;
  String? type;
  String? data;
  String? observations;
  List<String>? photos;

  LocalModel({
    this.latLng,
    this.description,
    this.type,
    this.data,
    this.observations,
    this.photos,
  });
}
