import 'package:engeselt_teste/app/models/local_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalStore {
  final locals = ValueNotifier<List<LocalModel>>([]);
  void addLocal(
      {LatLng? latLng,
      String? description,
      String? type,
      String? data,
      String? observations,
      List<String>? photos}) async {
    final local = LocalModel(
        latLng: latLng,
        description: description,
        type: type,
        data: data,
        observations: observations,
        photos: photos);
    final map = {local.id: local.toJson()};
    locals.value.add(local);
    locals.notifyListeners();
  }

  void removeLocal(int i) {
    locals.value.removeAt(i);
    locals.notifyListeners();
  }
}
