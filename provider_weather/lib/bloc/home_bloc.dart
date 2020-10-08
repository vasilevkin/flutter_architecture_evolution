import 'dart:async';

import 'package:bloc_weather/bloc/bloc.dart';
import 'package:bloc_weather/data/repository/storage_repo.dart';
import 'package:bloc_weather/model/city.dart';

class HomeBloc implements Bloc {
  final StorageRepository _repo;

  // Output streams
  Stream<List<City>> get citiesList => _repo.getCities;

  HomeBloc(this._repo);

  @override
  void dispose() {
    _repo.dispose();
  }

  void deleteCity(City city) async {
    await _repo.deleteCity(city);
  }
}
