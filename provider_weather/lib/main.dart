import 'package:flutter/material.dart';
import 'package:provider_weather/app/app.dart';
import 'package:provider_weather/data/repository/storage_impl_in_memory.dart';
import 'package:provider_weather/data/service/api_impl.dart';

void main() {
  final repo = StorageInMemoryImpl(api: MetaWeatherApi());

  runApp(ProviderWeatherApp(repo: repo));
}
