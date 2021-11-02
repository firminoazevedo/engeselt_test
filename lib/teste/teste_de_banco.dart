// ignore_for_file: prefer_const_constructors

import 'package:engeselt_teste/app/models/local_model.dart';
import 'package:engeselt_teste/app/services/database_handler.dart';
import 'package:engeselt_teste/app/store/local_store.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TesteDoApp extends StatefulWidget {
  const TesteDoApp({Key? key}) : super(key: key);

  @override
  _TesteDoAppState createState() => _TesteDoAppState();
}

class _TesteDoAppState extends State<TesteDoApp> {
  DatabaseHandler bd = DatabaseHandler();
  LatLng latLng = LatLng(45454, 787878787);

  @override
  Widget build(BuildContext context) {
    LocalStore localStore = LocalStore();
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                LocalModel localModel = LocalModel(
                    latLng: latLng,
                    data: '10/05/2015',
                    description: 'Casa do Pão',
                    observations: 'Aqui vende pão',
                    photos: ['http://', 'iuiuii'],
                    type: 'Privado');
                int id = await bd.insertLocal(localModel);
                localModel.id = id;
              },
              child: Text('Teste de inserir local')),
          ElevatedButton(
              onPressed: () async {
                List<LocalModel> locals = await bd.getLocals();
                for (var local in locals) {
                  print(local.id);
                }
              },
              child: Text('obter dados')),
          ElevatedButton(
              onPressed: () async {
                DatabaseHandler bd = DatabaseHandler();
                print(await bd.deleteLocal(1));
              },
              child: Text('deletar dado')),
        ],
      ),
    ));
  }
}
