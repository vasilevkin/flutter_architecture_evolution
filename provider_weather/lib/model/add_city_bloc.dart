import 'dart:async';

import 'package:provider_weather/bloc/bloc.dart';
import 'package:provider_weather/data/repository/storage_repo.dart';
import 'package:provider_weather/data_models/city.dart';

class AddCityBloc implements Bloc {
  final StorageRepository _repo;

  StreamController<List<City>> _suggestionsListStreamController =
      StreamController();
  StreamController<String> _queryStreamController = StreamController();
  StreamController<String> _selectedCityNameStreamController = StreamController();

  // Input sinks
  Sink<String> get queryString => _queryStreamController.sink;

  Sink<String> get selectedCityName => _selectedCityNameStreamController.sink;

  // Output streams
  Stream<List<City>> get suggestionsList =>
      _suggestionsListStreamController.stream;

  AddCityBloc(this._repo) {
    _processQuery();
    _addCityName();
  }

  @override
  void dispose() {
    _suggestionsListStreamController.close();
    _queryStreamController.close();
    _selectedCityNameStreamController.close();
  }

  void _addCityName() {
    _selectedCityNameStreamController.stream.listen((event) {
      _repo.addCity(event);
    });
  }

  void _processQuery() {
    _queryStreamController.stream.listen((event) {
      _onChangedText(event);
    });
  }

  void _onChangedText(String text) async {
    if (text == "" || text.length == 0) {
      _suggestionsListStreamController.sink.addError('Enter city name...');
    } else {
      try {
        final _cities = await _repo.searchCitiesByQuery(text);

        if (_cities.isEmpty) {
          _suggestionsListStreamController.sink
              .addError('<< City not found >>');
        } else {
          _suggestionsListStreamController.sink.add(_cities);
        }
      } catch (error) {
        _suggestionsListStreamController.sink.addError(error);
      }
    }
  }
}
