import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_multi_counter/multi_counter_store.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_multi_counter/screens/counter_view_page.dart';
import 'package:provider/provider.dart';

class CounterListPage extends StatelessWidget {
  const CounterListPage();

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<MultiCounterStore>(context);

    return Column(
      children: [
        RaisedButton(
          onPressed: store.addCounter,
          child: const Text(Constants.exampleMultiCounterAdd),
        ),
        Observer(
          builder: (_) => ListView.builder(
            shrinkWrap: true,
            itemCount: store.counters.length,
            itemBuilder: (_, index) => ListTile(
              trailing: const Icon(Icons.navigate_next),
              title: Observer(
                builder: (_) => Text(
                    '${Constants.exampleMultiCounterCount} ${store.counters[index].value}'),
              ),
              leading: IconButton(
                color: Colors.red,
                onPressed: () => store.removeCounter(index),
                icon: const Icon(Icons.delete),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(
                      title: const Text(Constants.exampleMultiCounterDetails),
                    ),
                    body: CounterViewPage(store: store, index: index),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
