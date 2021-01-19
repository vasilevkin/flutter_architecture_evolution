import 'package:flutter/material.dart';

class Constants {
  // API
  static const host = 'https://www.metaweather.com/';
  static const api = '$host/api/location/';

  // Decoration
  static const textShadows = [
    BoxShadow(
      color: Colors.black38,
      offset: Offset(3.0, 4.0),
      blurRadius: 5.0,
      spreadRadius: 15.0,
    ),
  ];

  // Strings
  static const String appTitle = 'Redux Weather';
  static const String exampleTitle = 'Redux demo example';
  static const String homeFABtooltip = 'Add a new city';
}
