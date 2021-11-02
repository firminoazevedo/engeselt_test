import 'package:engeselt_teste/app/models/local_model.dart';
import 'package:engeselt_teste/app/services/database_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalStore {
  LocalStore() {
    DatabaseHandler().getLocals().then((value) {
      locals.value = value;
    });
  }
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
  }

  void removeLocal(int i, int id) {
    DatabaseHandler().deleteLocal(id);
    locals.value.removeAt(i);
    locals.notifyListeners();
  }
}
