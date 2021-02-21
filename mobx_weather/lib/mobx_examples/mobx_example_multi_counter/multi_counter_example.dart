import 'package:flutter/material.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_multi_counter/screens/counter_list_page.dart';

class MultiCounterExample extends StatefulWidget {
  @override
  _MultiCounterExampleState createState() => _MultiCounterExampleState();
}

class _MultiCounterExampleState extends State<MultiCounterExample> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(Constants.exampleMultiCounterTitle),
        ),
        body: const CounterListPage(),
      );
}
