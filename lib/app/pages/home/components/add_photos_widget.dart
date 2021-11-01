// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPhotosWidget extends StatefulWidget {
  final List<String> photos;
  const AddPhotosWidget({Key? key, required this.photos}) : super(key: key);

  @override
  _AddPhotosWidgetState createState() => _AddPhotosWidgetState();
}

class _AddPhotosWidgetState extends State<AddPhotosWidget> {
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Expanded(
            child: Row(
              children: widget.photos.map((e) {
                final imgFile = File(e);
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
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
                                      final XFile? photo =
                                          await _picker.pickImage(
                                              source: ImageSource.camera);
                                      if (photo != null) {
                                        widget.photos.add(photo.path);
                                      }
                                      Navigator.pop(context);
                                    },
                                    child: Text('Camera')),
                                InkWell(
                                    onTap: () async {
                                      final XFile? photo =
                                          await _picker.pickImage(
                                              source: ImageSource.gallery);
                                      if (photo != null) {
                                        widget.photos.add(photo.path);
                                      }
                                      Navigator.pop(context);
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
      ),
    );
  }
}
