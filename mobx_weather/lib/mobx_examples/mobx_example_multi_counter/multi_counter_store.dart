import 'package:mobx/mobx.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_multi_counter/single_counter.dart';

part 'multi_counter_store.g.dart';

class MultiCounterStore = _MultiCounterStore with _$MultiCounterStore;

abstract class _MultiCounterStore with Store {
  final ObservableList<SingleCounter> counters =
      ObservableList<SingleCounter>.of([]);

  @action
  void addCounter() {
    counters.add(SingleCounter());
  }

  @action
  void removeCounter(int index) {
    counters.removeAt(index);
  }
}
