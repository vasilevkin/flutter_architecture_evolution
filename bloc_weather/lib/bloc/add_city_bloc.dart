import 'dart:async';

import 'package:bloc_weather/bloc/bloc.dart';
import 'package:bloc_weather/data/app_state.dart';
import 'package:bloc_weather/data/repository/storage_repo.dart';
import 'package:bloc_weather/model/city.dart';

class AddCityBloc implements Bloc {
  final StorageRepository _repo;

  final AppState appState;

  StreamController<List<City>> _suggestionsListStreamController =
      StreamController();
  StreamController<String> _queryStreamController = StreamController();

  // Input sinks
  Sink<String> get queryString => _queryStreamController.sink;

  // Output streams
  Stream<List<City>> get suggestionsList =>
      _suggestionsListStreamController.stream;

  AddCityBloc(
    this._repo,
    this.appState,
  ) {
    _processQuery();
  }

  @override
  void dispose() {
    _suggestionsListStreamController.close();
    _queryStreamController.close();
  }

  void _processQuery() {
    _queryStreamController.stream.listen((event) {
      _onChangedText(event);
    });
  }

  void _onChangedText(String text) async {
    print('bloc.onChangedText= $text');

    if (text == "" || text.length == 0) {
      _suggestionsListStreamController.sink.addError('Enter city name...');
    } else {
      try {
        final _cities = await appState.api.getCities(text);

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
