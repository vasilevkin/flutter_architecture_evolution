import 'package:flutter/foundation.dart';
import 'package:bloc_weather/data/repository/storage_repo.dart';
import 'package:bloc_weather/data/service/api_service.dart';
import 'package:bloc_weather/model/city.dart';

class AppState {
  bool isLoading;
  List<String> cityNames;
  City selectedCity;

  StorageRepository repo;
  ApiService api;

  AppState({
    this.isLoading = false,
    this.cityNames = const [],
    @required this.repo,
    @required this.api,
  });

  factory AppState.loading() => AppState(isLoading: true);
}
