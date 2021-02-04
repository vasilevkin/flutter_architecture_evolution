import 'package:flutter/material.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_reviews/screens/review.dart';

class ExampleHomePage extends StatefulWidget {
  final String title;

  const ExampleHomePage({Key key, this.title}) : super(key: key);

  @override
  _ExampleHomePageState createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Review(),
    );
  }
}
