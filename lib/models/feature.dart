import 'package:flutter/material.dart';

class Feature {
  String title;
  Color color;
  List<double> data;

  Feature({
    this.title = "",
    this.color = Colors.black,
    @required this.data,
  });
}
