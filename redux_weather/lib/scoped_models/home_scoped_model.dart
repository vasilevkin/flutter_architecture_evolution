import 'package:flutter/widgets.dart';
import 'package:redux_weather/data/repository/storage_repo.dart';
import 'package:redux_weather/data_models/city.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScopedModel extends Model {
  final StorageRepository repo;
  List<City> _citiesList;
  bool _isLoading = true;
  Error _error;

  List<City> get citiesList => _citiesList;

  bool get isLoading => _isLoading;

  Error get error => _error;

  static HomeScopedModel of(BuildContext context) =>
      ScopedModel.of<HomeScopedModel>(context, rebuildOnChange: true);

  HomeScopedModel({@required this.repo}) {
    loadCitiesList();
  }

  void _setCitiesList(List<City> list) {
    _citiesList = list;
    notifyListeners();
  }

  void loadCitiesList() {
    _isLoading = true;

    repo.getCities.listen(
      (event) {
        _error = null;
        _isLoading = false;
        _setCitiesList(event);
      },
    ).onError(
      (error) {
        _error = error;
        _isLoading = false;
        _setCitiesList(null);
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
