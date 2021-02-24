import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_dice/dice_counter.dart';
import 'package:provider/provider.dart';

class DiceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final diceCounter = Provider.of<DiceCounter>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: FlatButton(
                  child: Observer(
                    builder: (_) => Text(
                      '${diceCounter.left}',
                      style: TextStyle(fontSize: 128),
                    ),
                  ),
                  onPressed: diceCounter.roll,
                ),
              ),
              Expanded(
                child: FlatButton(
                  child: Observer(
                    builder: (_) => Text(
                      '${diceCounter.right}',
                      style: TextStyle(fontSize: 128),
                    ),
                  ),
                  onPressed: diceCounter.roll,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(36),
            child: Observer(
              builder: (_) => Text(
                '${Constants.exampleDiceTotal} ${diceCounter.total}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 36,
                    fontFamily: 'Verdana'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
