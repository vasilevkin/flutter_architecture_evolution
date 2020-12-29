import 'package:flutter/material.dart';
import 'package:scoped_model_weather/app/app.dart';
import 'package:scoped_model_weather/data/repository/storage_impl_in_memory.dart';
import 'package:scoped_model_weather/data/service/api_impl.dart';

void main() {
  final repo = StorageInMemoryImpl(api: MetaWeatherApi());

  runApp(ScopedModelWeatherApp(repo: repo));
}
