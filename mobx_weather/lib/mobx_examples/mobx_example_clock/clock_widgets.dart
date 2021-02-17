import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_clock/clock.dart';

class ClockExample extends StatefulWidget {
  const ClockExample();

  @override
  _ClockExampleState createState() => _ClockExampleState();
}

class _ClockExampleState extends State<ClockExample> {
  final Clock clock = Clock();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(Constants.exampleClockTitle),
        ),
        body: Center(
          child: Observer(
            builder: (_) {
              final time = clock.now;
              final formattedTime =
                  [time.hour, time.minute, time.second].join(':');

              return Text(
                formattedTime,
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              );
            },
          ),
        ),
      );
}
