// ignore_for_file: prefer_const_constructors

import 'package:engeselt_teste/app/pages/shared/styles.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 23, vertical: 3),
      decoration: DECORATION_SHADOW,
      child: DropdownButton<String>(
          underline: SizedBox(),
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
