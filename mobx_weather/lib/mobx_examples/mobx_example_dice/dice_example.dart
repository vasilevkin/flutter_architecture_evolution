import 'package:flutter/material.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_dice/dice_view.dart';

class DiceExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: Text(
          Constants.exampleDiceTap,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 30,
            fontFamily: 'Hind',
          ),
        ),
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
        child: DiceView(),
      ),
    );
  }
}
