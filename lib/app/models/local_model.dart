import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class LocalModel {
  int? id;
  LatLng? latLng;
  String? description;
  String? type;
  String? data;
  String? observations;
  List<String>? photos;

  LocalModel({
    this.id,
    this.latLng,
    this.description,
    this.type,
    this.data,
    this.observations,
    this.photos,
  });

  factory LocalModel.fromJson(Map<String, dynamic> map, List<String> photos) {
    LatLng latLng =
        LatLng(double.parse(map['latitude']), double.parse(map['longitude']));
    return LocalModel(
      id: map['id'],
      latLng: latLng,
      description: map['description'],
      type: map['type'],
      observations: map['observations'],
      data: map['data'],
      photos: photos,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latLng!.latitude,
      'longitude': latLng!.longitude,
      'description': description,
      'type': type,
      'data': data,
      'observations': observations,
      'photos': photos
    };
  }
}
