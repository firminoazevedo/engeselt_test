// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomDropDowm extends StatelessWidget {
  const CustomDropDowm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 23),
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
      child: DropdownButton<String>(
          isExpanded: true,
          onChanged: (value) {},
          hint: Text('Tipo'),
          items: ['Privado', 'Público', 'Outros'].map((e) {
            return DropdownMenuItem(value: e, child: Text(e));
          }).toList()),
    );
  }
}
