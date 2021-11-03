// ignore_for_file: prefer_const_constructors

import 'package:engeselt_teste/app/pages/shared/styles.dart';
import 'package:flutter/material.dart';

class CardWhiteComponent extends StatelessWidget {
  final Widget child;
  const CardWhiteComponent({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: DECORATION_SHADOW,
      child: child,
    );
  }
}
