import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:mobx_weather/app/constants.dart';

class Clock {
  Atom _atom;
  Timer _timer;

  DateTime get now {
    _atom.reportObserved();
    return DateTime.now();
  }

  Clock() {
    _atom = Atom(
      name: Constants.exampleClockAtom,
      onObserved: _startTimer,
      onUnobserved: _stopTimer,
    );
  }

  void _startTimer() {
    print(Constants.exampleClockStarted);

    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    print(Constants.exampleClockStopped);
  }

  void _onTick(_) {
    _atom.reportChanged();
  }
}
