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
