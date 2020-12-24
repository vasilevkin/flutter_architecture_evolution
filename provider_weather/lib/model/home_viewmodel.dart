import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:provider_weather/data/repository/storage_repo.dart';
import 'package:provider_weather/data_models/city.dart';

/*

implements
all_city_model
add_city_model


move all logic from data/ packages to model/
separate models

 */

class HomeViewModel extends ChangeNotifier {
  final StorageRepository _repo;
  List<City> _citiesList;
  bool _isLoading = true;

  List<City> get citiesList => _citiesList;

  bool get isLoading => _isLoading;

  var error;

  HomeViewModel(this._repo);

  @override
  void dispose() {
    _repo.dispose();
    super.dispose();
  }

  Future loadCitiesList() {
    _isLoading = true;

    _repo.getCities.listen(
      (event) {
        _citiesList = event;
        this.error = null;
        _isLoading = false;
        notifyListeners();
      },
    ).onError(
      (error) {
        _citiesList = null;
        this.error = error;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  void deleteCity(City city) async {
    await _repo.deleteCity(city);
    notifyListeners();
  }
}
