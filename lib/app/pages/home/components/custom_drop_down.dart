// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomDropDowm extends StatefulWidget {
  final TextEditingController? textEditingController;
  const CustomDropDowm({Key? key, this.textEditingController})
      : super(key: key);

  @override
  State<CustomDropDowm> createState() => _CustomDropDowmState();
}

class _CustomDropDowmState extends State<CustomDropDowm> {
  bool changedTitle = false;
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
          onChanged: (value) {
            widget.textEditingController!.text = value!;
            changedTitle = true;
            setState(() {});
          },
          hint:
              Text(changedTitle ? widget.textEditingController!.text : 'Tipo'),
          items: ['Privado', 'Público', 'Outros'].map((e) {
            return DropdownMenuItem(value: e, child: Text(e));
          }).toList()),
    );
  }
}
