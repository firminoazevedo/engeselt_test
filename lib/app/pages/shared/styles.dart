import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final DECORATION_SHADOW = BoxDecoration(
  color: Colors.white,
  borderRadius: const BorderRadius.all(Radius.circular(12)),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.15),
      spreadRadius: 3,
      blurRadius: 7,
      offset: const Offset(0, 3),
    ),
  ],
);
