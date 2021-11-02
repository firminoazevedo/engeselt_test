// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:engeselt_teste/app/models/local_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'teste3.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE locals(id INTEGER PRIMARY KEY AUTOINCREMENT, latitude TEXT NOT NULL, longitude TEXT NOT NULL, description TEXT NOT NULL, observations TEXT NOT NULL, type TEXT NOT NULL, data TEXT NOT NULL)",
        );
        await database.execute(
          "CREATE TABLE locals_photos(id INTEGER PRIMARY KEY AUTOINCREMENT, id_local INTEGER NOT NULL, photo TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertLocal(LocalModel localModel) async {
    Map<String, dynamic> mapLocal = {
      'latitude': localModel.latLng!.latitude,
      'longitude': localModel.latLng!.longitude,
      'description': localModel.description,
      'type': localModel.type,
      'data': localModel.data,
      'observations': localModel.observations
    };
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert('locals', mapLocal);

    for (var photo in localModel.photos!) {
      Map<String, dynamic> mapPhoto = {
        'id_local': result,
        'photo': photo,
      };
      await db.insert('locals_photos', mapPhoto);
    }
    return result;
  }

  Future<List<LocalModel>> getLocals() async {
    List<LocalModel> locals = [];
    final Database db = await initializeDB();

    final List<Map<String, Object?>> listLocalsFromDatabase =
        await db.query('locals');

    for (var localMap in listLocalsFromDatabase) {
      List<String> photos = await getPhotosOfLocal(localMap);
      LocalModel localModel = LocalModel.fromJson(localMap, photos);
      print(localModel.toJson());
      locals.add(localModel);
    }
    return locals;
  }

  Future<List<String>> getPhotosOfLocal(Map<String, Object?> mapLocals) async {
    final Database db = await initializeDB();
    List<String> photos = [];
    List<Map<String, Object?>> photosFromDatabaseMap = await db.rawQuery(
        'SELECT * FROM locals_photos WHERE id_local = ${mapLocals['id']}');

    for (var photosMap in photosFromDatabaseMap) {
      photos.add(photosMap['photo'].toString());
    }
    return photos;
  }

  Future<int> deleteLocal(int id) async {
    print(id);
    final Database db = await initializeDB();
    return await db.delete('locals', where: 'id = ?', whereArgs: [id]);
  }
}
