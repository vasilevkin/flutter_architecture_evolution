import 'package:flutter/material.dart';
import 'package:mobx_weather/app/app.dart';
import 'package:mobx_weather/redux/redux.dart';

void main() async {
  await Redux.init();

  final store = Redux.store;

  runApp(MobxWeatherApp(repo: store.state.repo, store: store));
}
