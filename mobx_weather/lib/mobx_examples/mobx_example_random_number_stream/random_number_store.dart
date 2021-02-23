import 'dart:async';
import 'dart:math';

import 'package:mobx/mobx.dart';

part 'random_number_store.g.dart';

class RandomStore = _RandomStore with _$RandomStore;

abstract class _RandomStore with Store {
  Timer _timer;
  final _random = Random();
  StreamController<int> _streamController;
  ObservableStream<int> randomStream;

  _RandomStore() {
    _streamController = StreamController<int>();

    _timer = Timer.periodic(const Duration(seconds: 1),
        (_) => _streamController.add(_random.nextInt(100)));

    randomStream = ObservableStream(_streamController.stream);
  }

  void dispose() async {
    _timer.cancel();
    await _streamController.close();
  }
}
