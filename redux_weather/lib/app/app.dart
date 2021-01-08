import 'package:flutter/material.dart';
import 'package:redux_weather/redux_example/example_screen.dart';

class ReduxWeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [
            FlatButton(
              onPressed: () {
                exampleMain();
              },
              child: Icon(Icons.redeem),
            ),
          ],
        ),
        body: Container(),
      ),
    );
  }
}
