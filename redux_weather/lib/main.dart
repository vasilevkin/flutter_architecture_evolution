import 'package:flutter/material.dart';
import 'package:redux_weather/app/app.dart';
import 'package:redux_weather/redux/redux.dart';

void main() async {
  await Redux.init();

  final store = Redux.store;

  runApp(ReduxWeatherApp(repo: store.state.repo, store: store));
}
