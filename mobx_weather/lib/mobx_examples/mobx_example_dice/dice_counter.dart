import 'dart:math';

import 'package:mobx/mobx.dart';
part 'dice_counter.g.dart';

class DiceCounter = _DiceCounter with _$DiceCounter;

abstract class _DiceCounter with Store {
  @observable
  int left = _getScore();

  @observable
  int right = _getScore();

  @computed
  int get total => left + right;

  @action
  void roll() {
    left = _getScore();
    right = _getScore();
  }

  static int _getScore() => Random().nextInt(6) + 1;
}
