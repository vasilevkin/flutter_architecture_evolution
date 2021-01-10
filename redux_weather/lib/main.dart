import 'package:flutter/material.dart';
import 'package:redux_weather/app/app.dart';
import 'package:redux_weather/data/repository/storage_impl_in_memory.dart';
import 'package:redux_weather/data/service/api_impl.dart';

void main() {
  final repo = StorageInMemoryImpl(api: MetaWeatherApi());

  runApp(ReduxWeatherApp(repo: repo));

  // runApp(ReduxWeatherApp());
}
