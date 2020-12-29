import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_model_weather/data/repository/storage_repo.dart';
import 'package:scoped_model_weather/data_models/city.dart';

/*

implements
all_city_model
add_city_model


move all logic from data/ packages to model/
separate models

 */

class HomeScopedModel extends Model {
  final StorageRepository repo;
  List<City> _citiesList;
  bool _isLoading = true;
  Error _error;

  List<City> get citiesList => _citiesList;

  bool get isLoading => _isLoading;

  Error get error => _error;

  static HomeScopedModel of(BuildContext context) =>
      ScopedModel.of<HomeScopedModel>(context);

  HomeScopedModel({@required this.repo});

  void loadCitiesList() {
    _isLoading = true;

    repo.getCities.listen(
      (event) {
        _citiesList = event;
        _error = null;
        _isLoading = false;
        notifyListeners();
      },
    ).onError(
      (error) {
        _citiesList = null;
        _error = error;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  void deleteCity(City city) async {
    await repo.deleteCity(city);
    notifyListeners();
  }

  void setSelectedCity(City city) {
    repo.setSelectedCity(city);
    notifyListeners();
  }

  Image getImageForStateAbbr(String abbr) => repo.getImageForStateAbbr(abbr);
}
