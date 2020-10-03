import 'dart:async';

import 'package:bloc_weather/bloc/Bloc.dart';
import 'package:bloc_weather/data/repository/storage_repo.dart';
import 'package:bloc_weather/model/city.dart';

class HomeBloc implements Bloc {
  final StorageRepository _repo;
  var _cities = List<City>();
  StreamController<List<City>> _citiesListStreamController = StreamController();

  // Output streams
  Stream<List<City>> get citiesList => _citiesListStreamController.stream;

  HomeBloc(this._repo) {
    loadCitiesData();
  }

  @override
  void dispose() {
    _citiesListStreamController.close();
  }

  void loadCitiesData() async {
    try {
      _cities = await _repo.getAllCities();
    } catch (error) {
      _citiesListStreamController.sink.addError(error);
      return;
    }

    _citiesListStreamController.sink.add(_cities);
  }

  void deleteCity(City city) async {
    try {
      await _repo.deleteCity(city);
    } catch (error) {
      _citiesListStreamController.sink.addError(error);
      return;
    }

    loadCitiesData();
  }

  void editCity(City city) async {
    try {
      await _repo.updateCity(city);
    } catch (error) {
      _citiesListStreamController.sink.addError(error);
      return;
    }

    loadCitiesData();
  }
}
