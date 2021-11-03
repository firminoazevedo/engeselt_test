// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'dart:io';

import 'package:engeselt_teste/app/models/local_model.dart';
import 'package:engeselt_teste/app/pages/shared/component.dart';
import 'package:flutter/material.dart';

class LocalDetailsPage extends StatefulWidget {
  final LocalModel localModel;

  LocalDetailsPage({Key? key, required this.localModel}) : super(key: key);

  @override
  _LocalDetailsPageState createState() => _LocalDetailsPageState();
}

class _LocalDetailsPageState extends State<LocalDetailsPage> {
  String? _currentImg;
  @override
  void initState() {
    _currentImg = widget.localModel.photos![0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.localModel.description!),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width + 40,
                child: Image.file(
                  File(_currentImg ?? widget.localModel.photos![0]),
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.localModel.photos!.map((e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        _currentImg = e;
                        setState(() {});
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            height: 80,
                            width: 80,
                            child: Image.file(
                              File(e),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardWhiteComponent(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Descrição',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w900),
                        ),
                        Text('${widget.localModel.description}'),
                      ],
                    ),
                  ),
                  CardWhiteComponent(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Tipo do local',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w900)),
                        Text('${widget.localModel.type}'),
                      ],
                    ),
                  ),
                  CardWhiteComponent(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Data de visita',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w900)),
                        Text('${widget.localModel.data}'),
                      ],
                    ),
                  ),
                  CardWhiteComponent(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Cordenadas',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w900)),
                        Text(
                            'Latitude:  ${widget.localModel.latLng!.latitude}'),
                        Text(
                            'Longitude:  ${widget.localModel.latLng!.longitude}'),
                      ],
                    ),
                  ),
                  CardWhiteComponent(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Observações',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w900)),
                        Text('${widget.localModel.observations}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.edit),
      ),
    );
  }
}
