import 'package:flutter/widgets.dart';
import 'package:provider_weather/data/repository/storage_repo.dart';
import 'package:provider_weather/data_models/city.dart';

class AddCityViewModel extends ChangeNotifier {
  final StorageRepository repo;

  List<City> _suggestionsList;
  bool _isLoading = true;
  ArgumentError _error;

  List<City> get suggestionsList => _suggestionsList;

  bool get isLoading => _isLoading;

  ArgumentError get error => _error;

  AddCityViewModel({@required this.repo}) {
    clearViewModel();
    notifyListeners();
  }

  void setSelectedCityName(String name) {
    repo.addCity(name);
    clearViewModel();
    notifyListeners();
  }

  void setQueryString(String text) {
    _onChangedText(text);
    clearViewModel();
  }

  void clearViewModel() {
    _suggestionsList = null;
    _error = null;
    _isLoading = false;
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
}
