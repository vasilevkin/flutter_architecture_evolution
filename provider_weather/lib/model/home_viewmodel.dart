import 'dart:async';

import 'package:provider_weather/bloc/bloc.dart';
import 'package:provider_weather/data/repository/storage_repo.dart';
import 'package:provider_weather/data_models/city.dart';

/*

implements
all_city_model
add_city_model


move all logic from data/ packages to model/
separate models

 */

class HomeViewModel implements DisposableViewModel {
  final StorageRepository _repo;

  // Output streams
  Stream<List<City>> get citiesList => _repo.getCities;

  HomeViewModel(this._repo);

  @override
  void dispose() {
    _repo.dispose();
  }

  void deleteCity(City city) async {
    await _repo.deleteCity(city);
  }
}
