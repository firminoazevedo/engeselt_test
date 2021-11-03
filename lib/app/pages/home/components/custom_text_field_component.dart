// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:engeselt_teste/app/pages/shared/styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String hint;
  IconData icon;
  TextEditingController textEditingController;

  CustomTextField(
      {Key? key,
      required this.hint,
      required this.icon,
      required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        decoration: DECORATION_SHADOW,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              icon: Icon(icon),
              border: InputBorder.none,
              isDense: true,
              hintText: hint,
            ),
          ),
        ),
      ),
    );
  }
}
