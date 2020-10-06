import 'dart:async';

import 'package:bloc_weather/bloc/bloc.dart';
import 'package:bloc_weather/data/repository/storage_repo.dart';
import 'package:bloc_weather/model/city.dart';

class EditCityBloc implements Bloc {
  final StorageRepository _repo;

  StreamController<List<City>> _suggestionsListStreamController =
      StreamController();
  StreamController<String> _queryStreamController = StreamController();

  StreamController<City> _selectedCityNameStreamController = StreamController();

  // Input sinks
  Sink<String> get queryString => _queryStreamController.sink;

  Sink<City> get selectedCityName => _selectedCityNameStreamController.sink;

  // Output streams
  Stream<List<City>> get suggestionsList =>
      _suggestionsListStreamController.stream;

  EditCityBloc(this._repo) {
    _processQuery();
    _editCityName();
  }

  @override
  void dispose() {
    _suggestionsListStreamController.close();
    _queryStreamController.close();
    _selectedCityNameStreamController.close();
  }

  void _editCityName() {
    _selectedCityNameStreamController.stream.listen((event) {
      _repo.updateCity(event);
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
