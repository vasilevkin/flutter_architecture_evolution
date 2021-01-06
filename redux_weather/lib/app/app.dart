import 'package:flutter/material.dart';

class ReduxWeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [
            FlatButton(
              onPressed: () {},
              child: Icon(Icons.redeem),
            ),
          ],
        ),
        body: Container(),
      ),
    );
  }
}
