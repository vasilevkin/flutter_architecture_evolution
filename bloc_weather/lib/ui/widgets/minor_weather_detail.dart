import 'package:flutter/material.dart';
import 'package:bloc_weather/app/constants.dart';

class MinorWeatherDetail extends StatelessWidget {
  final String name;
  final String value;

  const MinorWeatherDetail({this.name, this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.transparent,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Text(
            name,
            style: TextStyle(color: Colors.white, shadows: textShadows),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              shadows: textShadows,
            ),
          ),
        ],
      ),
    );
  }
}
