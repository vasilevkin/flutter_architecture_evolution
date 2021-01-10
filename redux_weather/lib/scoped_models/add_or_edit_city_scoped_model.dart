import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:redux_weather/data/repository/storage_repo.dart';
import 'package:redux_weather/data_models/city.dart';

class AddOrEditCityScopedModel extends Model {
  final StorageRepository repo;

  List<City> _suggestionsList;
  bool _isLoading = true;
  ArgumentError _error;
  City _selectedCity = City();

  List<City> get suggestionsList => _suggestionsList;

  bool get isLoading => _isLoading;

  ArgumentError get error => _error;

  String get selectedCityName {
    _getSelectedCityFromRepo();

    if (_selectedCity != null) {
      return _selectedCity.name ?? 'No name';
    }
    return 'Name is not defined';
  }

  static AddOrEditCityScopedModel of(BuildContext context) =>
      ScopedModel.of<AddOrEditCityScopedModel>(context, rebuildOnChange: true);

  AddOrEditCityScopedModel({@required this.repo}) {
    clearScopedModel();
    _getSelectedCityFromRepo();
    notifyListeners();
  }

  void setQueryString(String text) {
    _onChangedText(text);
    clearScopedModel();
  }

  void setSelectedCity(City city) {
    repo.setSelectedCity(city);
  }

  void addSelectedCityName(String name) {
    repo.addCity(name);
  }

  void updateCity(City city) {
    repo.updateCity(city);
    _getSelectedCityFromRepo();
    clearScopedModel();
    notifyListeners();
  }

  void clearScopedModel() {
    _suggestionsList = null;
    _error = null;
    _isLoading = false;
    _selectedCity = null;
  }

  void _onChangedText(String text) async {
    _isLoading = true;

    if (text == "" || text.length == 0) {
      _error = ArgumentError('Enter some city name...');
      _suggestionsList = null;
      _isLoading = false;
    } else {
      try {
        final _cities = await repo.searchCitiesByQuery(text);

        if (_cities.isEmpty) {
          _error = ArgumentError('<< City not found >>');
          _suggestionsList = null;
        } else {
          _suggestionsList = _cities;
          _error = null;
        }
      } catch (error) {
        _suggestionsList = null;
        _error = ArgumentError(error.toString());
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  void _getSelectedCityFromRepo() {
    _selectedCity = repo.getSelectedCity();
  }
}
