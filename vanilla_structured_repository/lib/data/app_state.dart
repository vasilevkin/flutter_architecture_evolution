import 'package:flutter/cupertino.dart';
import 'package:vanilla_structured_repository/data/service/api_impl.dart';
import 'package:vanilla_structured_repository/data/service/api_service.dart';
import 'package:vanilla_structured_repository/data/repository/storage_repo.dart';
import 'package:vanilla_structured_repository/model/weather.dart';

class AppState {
  bool isLoading;
  List<String> cityNames;
  CityWeather selectedCityWeather;

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
