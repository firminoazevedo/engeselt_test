import 'package:engeselt_teste/app/models/local_model.dart';
import 'package:flutter/cupertino.dart';

class LocalStore {
  final locals = ValueNotifier<List<LocalModel>>([]);
  void addLocal(
      {String? latLang,
      String? description,
      String? type,
      String? data,
      String? observations,
      List<String>? photos}) {
    final local = LocalModel(
        latLang: latLang,
        type: type,
        data: data,
        observations: observations,
        photos: photos);
    locals.value.add(local);
    locals.notifyListeners();
  }

  void removeLocal() {}
}
