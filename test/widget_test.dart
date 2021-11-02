import 'package:engeselt_teste/app/services/database_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('teste de conexão com o banco', () async {
    DatabaseHandler bd = DatabaseHandler();
    print(await bd.initializeDB());
  });
}
