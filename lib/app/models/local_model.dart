import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class LocalModel {
  String id = DateTime.now().millisecondsSinceEpoch.toString();
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

  Map<String, dynamic> toJson() {
    return {
      'latLng': {
        'latitude': latLng!.latitude,
        'longitude': latLng!.longitude,
      },
      'description': description,
      'type': type,
      'data': data,
      'observations': observations,
      'photos': photos
    };
  }
}
