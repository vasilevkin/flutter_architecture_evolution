import 'dart:async';

import 'package:bloc_weather/data/repository/storage_repo.dart';
import 'package:bloc_weather/model/city.dart';

class HomeBloc {
  final StorageRepository _repo;

  HomeBloc(this._repo);

  // Output streams

  Stream<List<City>> citiesList() => _repo.getAllCities().asStream();
}
