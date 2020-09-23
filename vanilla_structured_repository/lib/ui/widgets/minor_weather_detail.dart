import 'package:flutter/material.dart';
import 'package:vanilla_structured_repository/app/constants.dart';

class MinorWeatherDetail extends StatelessWidget {
  final String name;
  final String value;

  const MinorWeatherDetail({this.name, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          name,
          style: TextStyle(color: Colors.white54, shadows: textShadows),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white54,
            shadows: textShadows,
          ),
        ),
      ],
    );
  }
}