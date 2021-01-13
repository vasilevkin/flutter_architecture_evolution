import 'package:flutter/material.dart';
import 'package:redux_weather/app/app.dart';
import 'package:redux_weather/data/repository/storage_impl_in_memory.dart';
import 'package:redux_weather/data/service/api_impl.dart';
import 'package:redux_weather/redux/store.dart';

void main() async {
  final repo = StorageInMemoryImpl(api: MetaWeatherApi());

  await Redux.init();
  runApp(ReduxWeatherApp(repo: repo, store: Redux.store));
}
