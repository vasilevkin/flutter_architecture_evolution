import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_weather/app/constants.dart';import 'package:mobx_weather/mobx_examples/mobx_example_random_number_stream/random_number_store.dart';

class RandomNumberExample extends StatefulWidget {
  const RandomNumberExample();

  @override
  _RandomNumberExampleState createState() => _RandomNumberExampleState();
}

class _RandomNumberExampleState extends State<RandomNumberExample> {
  final RandomStore store = RandomStore();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(Constants.exampleRandomNumberStreamTitle),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Constants.exampleRandomNumberRandomNumber,
                style: TextStyle(color: Colors.grey),
              ),
              Observer(
                builder: (_) {
                  final value = store.randomStream.value;

                  return Text(
                    '${value == null ? '---' : value}',
                    style: const TextStyle(fontSize: 100),
                  );
                },
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }
}
