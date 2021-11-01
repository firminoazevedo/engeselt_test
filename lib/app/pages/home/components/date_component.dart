// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateComponent extends StatefulWidget {
  String hint;
  IconData icon;
  TextEditingController textEditingController;

  DateComponent(
      {Key? key,
      required this.hint,
      required this.icon,
      required this.textEditingController})
      : super(key: key);

  @override
  State<DateComponent> createState() => _DateComponentState();
}

class _DateComponentState extends State<DateComponent> {
  @override
  void initState() {
    widget.textEditingController.text = 'Data da visita';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: ListTile(
        leading: IconButton(
            onPressed: () async {
              final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2010),
                  lastDate: DateTime(2022));
              widget.textEditingController.text =
                  DateFormat.yMMMMEEEEd().format(date!);
              setState(() {});
            },
            icon: Icon(Icons.calendar_today)),
        title: Text(widget.textEditingController.text),
      ),
    );
  }
}
