import 'package:mobx/mobx.dart';

part 'single_counter.g.dart';

class SingleCounter = _SingleCounter with _$SingleCounter;

abstract class _SingleCounter with Store {
  @observable
  int value = 0;

  @action
  void reset() {
    value = 0;
  }

  @action
  void increment() {
    value++;
  }

  @action
  void decrement() {
    value--;
  }
}
