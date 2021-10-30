import 'package:flutter/material.dart';

class LocalDetailsPage extends StatefulWidget {
  const LocalDetailsPage({Key? key}) : super(key: key);

  @override
  _LocalDetailsPageState createState() => _LocalDetailsPageState();
}

class _LocalDetailsPageState extends State<LocalDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('LatLang'),
          Text('Descrição'),
          Text('Tipo'),
          Text('Data'),
          Text('Observações'),
          Text('Photos')
        ],
      ),
    );
  }
}
