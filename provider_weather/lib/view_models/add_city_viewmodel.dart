import 'dart:async';

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

  StreamController<String> _queryStreamController = StreamController();
  StreamController<String> _selectedCityNameStreamController =
      StreamController();

  // Input sinks
  Sink<String> get queryString => _queryStreamController.sink;

  Sink<String> get selectedCityName => _selectedCityNameStreamController.sink;

  AddCityViewModel({@required this.repo}) {
    _processQuery();
    _addCityName();
    notifyListeners();
  }

  @override
  void dispose() {
    _queryStreamController.close();
    _selectedCityNameStreamController.close();
    super.dispose();
  }

  void _addCityName() {
    _selectedCityNameStreamController.stream.listen((event) {
      repo.addCity(event);
      _error = null;
      _suggestionsList = null;
      notifyListeners();
    });
  }

  void _processQuery() {
    _suggestionsList = null;
    _error = null;
    _isLoading = false;
    _queryStreamController.stream.listen((event) {
      _onChangedText(event);
    });
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
