// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:engeselt_teste/app/models/local_model.dart';
import 'package:flutter/material.dart';

class LocalDetailsPage extends StatefulWidget {
  final LocalModel localModel;

  LocalDetailsPage({Key? key, required this.localModel}) : super(key: key);

  @override
  _LocalDetailsPageState createState() => _LocalDetailsPageState();
}

class _LocalDetailsPageState extends State<LocalDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('LatLang ${widget.localModel.latLng}'),
            Text('Descrição ${widget.localModel.description}'),
            Text('Tipo ${widget.localModel.type}'),
            Text('Data ${widget.localModel.data}'),
            Text('Observações ${widget.localModel.observations}'),
            Text('Photos ${widget.localModel.photos}')
          ],
        ),
      ),
    );
  }
}
