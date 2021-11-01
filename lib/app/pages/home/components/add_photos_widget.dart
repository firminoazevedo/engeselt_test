// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPhotosWidget extends StatefulWidget {
  const AddPhotosWidget({Key? key}) : super(key: key);

  @override
  _AddPhotosWidgetState createState() => _AddPhotosWidgetState();
}

class _AddPhotosWidgetState extends State<AddPhotosWidget> {
  final ImagePicker _picker = ImagePicker();
  List<XFile?> photos = [];
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: photos.map((e) {
            final imgFile = File(e!.path);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                    height: 80,
                    width: 80,
                    child: Image.file(
                      imgFile,
                      fit: BoxFit.cover,
                    )),
              ),
            );
          }).toList(),
        ),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: IconButton(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                  onTap: () async {
                                    final XFile? photo = await _picker
                                        .pickImage(source: ImageSource.camera);
                                    if (photo != null) {
                                      photos.add(photo);
                                    }
                                  },
                                  child: Text('Camera')),
                              InkWell(
                                  onTap: () async {
                                    final XFile? photo = await _picker
                                        .pickImage(source: ImageSource.gallery);
                                    if (photo != null) {
                                      photos.add(photo);
                                    }
                                  },
                                  child: Text('Galeria')),
                            ],
                          ),
                        ),
                      );
                    });
                setState(() {});
              },
              icon: Icon(
                Icons.add_a_photo,
                color: Colors.grey,
              )),
        ),
      ],
    );
  }
}
