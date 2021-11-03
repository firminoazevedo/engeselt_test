// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:engeselt_teste/app/models/local_model.dart';
import 'package:engeselt_teste/app/services/database_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalStore {
  LocalStore() {
    DatabaseHandler().getLocals().then((value) {
      locals.value = value;
      loadMarker();
    });
  }

  final markers = ValueNotifier<Set<Marker>>({});

  final locals = ValueNotifier<List<LocalModel>>([]);
  void addLocal(
      {LatLng? latLng,
      String? description,
      String? type,
      String? data,
      String? observations,
      List<String>? photos}) async {
    final localModel = LocalModel(
        latLng: latLng,
        description: description,
        type: type,
        data: data,
        observations: observations,
        photos: photos);

    int id = await DatabaseHandler().insertLocal(localModel);
    localModel.id = id;

    locals.value.add(localModel);
    locals.notifyListeners();
    addMarker(localModel);
  }

  void removeLocal(int i, int id) {
    DatabaseHandler().deleteLocal(id);
    markers.value.removeWhere((element) {
      if (element.markerId.value == id.toString()) {
        return true;
      }
      return false;
    });
    markers.notifyListeners();
    locals.value.removeAt(i);
    locals.notifyListeners();
  }

  loadMarker() async {
    for (var local in locals.value) {
      markers.value.add(Marker(
        position: local.latLng!,
        infoWindow: InfoWindow(title: local.description),
        markerId: MarkerId(local.id.toString()),
      ));
    }
    markers.notifyListeners();
  }

  addMarker(LocalModel local) {
    markers.value.add(Marker(
      position: local.latLng!,
      infoWindow: InfoWindow(title: local.description),
      markerId: MarkerId(local.id.toString()),
    ));

    markers.notifyListeners();
  }
}
