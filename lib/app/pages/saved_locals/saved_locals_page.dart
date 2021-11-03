// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:engeselt_teste/app/models/local_model.dart';
import 'package:engeselt_teste/app/pages/local_details/local_details.dart';
import 'package:engeselt_teste/app/pages/shared/styles.dart';
import 'package:engeselt_teste/app/store/local_store.dart';
import 'package:flutter/material.dart';

class SavedLocals extends StatefulWidget {
  final LocalStore localStore;
  const SavedLocals({Key? key, required this.localStore}) : super(key: key);

  @override
  _SavedLocalsState createState() => _SavedLocalsState();
}

class _SavedLocalsState extends State<SavedLocals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pontos de interesses salvos'),
      ),
      body: ValueListenableBuilder<List<LocalModel>>(
        valueListenable: widget.localStore.locals,
        builder: (context, locals, child) {
          return ListView.builder(
            itemCount: locals.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LocalDetailsPage(
                                localModel: locals[i],
                              )));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: DECORATION_SHADOW,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                          ),
                          width: 50,
                          height: 50,
                          child: Image.file(
                            File(locals[i].photos![0]),
                            fit: BoxFit.cover,
                          )),
                    ),
                    title: Text(locals[i].description!),
                    subtitle: Text(locals[i].observations!),
                    trailing: IconButton(
                        onPressed: () {
                          widget.localStore.removeLocal(i, locals[i].id!);
                        },
                        icon: Icon(Icons.delete)),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
