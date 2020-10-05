import 'package:flutter/foundation.dart';
import 'package:bloc_weather/data/repository/storage_repo.dart';
import 'package:bloc_weather/data/service/api_service.dart';
import 'package:bloc_weather/model/city.dart';

class AppState {
  StorageRepository repo;

  AppState({
    @required this.repo,
  });
}
