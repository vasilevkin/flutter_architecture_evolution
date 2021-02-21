import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_multi_counter/multi_counter_store.dart';

class CounterViewPage extends StatelessWidget {
  const CounterViewPage({@required this.store, @required this.index});

  final int index;
  final MultiCounterStore store;

  @override
  Widget build(BuildContext context) {
    final counter = store.counters[index];

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                RaisedButton(
                  onPressed: counter.decrement,
                  child: const Icon(Icons.remove),
                ),
                Expanded(
                  child: Center(
                    child: Observer(
                      builder: (_) => Text(
                        '${counter.value}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: counter.increment,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            FlatButton(
              textColor: Colors.red,
              onPressed: counter.reset,
              child: const Text(Constants.exampleMultiCounterReset),
            ),
          ],
        ),
      ),
    );
  }
}
