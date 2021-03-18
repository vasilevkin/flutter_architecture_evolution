import 'package:flutter/material.dart';
import 'package:getx_weather/app/app.dart';
import 'package:getx_weather/redux/redux.dart';

void main() async {
  await Redux.init();

  final store = Redux.store;

  runApp(GetxWeatherApp(repo: store.state.repo, store: store));
}
