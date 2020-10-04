import 'dart:async';

import 'package:bloc_weather/bloc/bloc.dart';
import 'package:bloc_weather/data/app_state.dart';
import 'package:bloc_weather/data/repository/storage_repo.dart';
import 'package:bloc_weather/model/city.dart';

class AddCityBloc implements Bloc {
  final StorageRepository _repo;
  var _cities = List<City>();

  final AppState appState;

  StreamController<List<City>> _suggestionsListStreamController =
      StreamController();

  // Output streams
  Stream<List<City>> get suggestionsList =>
      _suggestionsListStreamController.stream;

  AddCityBloc(
    this._repo,
    this.appState,
  );

  @override
  void dispose() {
    _suggestionsListStreamController.close();
  }

  void onChangedText(String text) async {
    print('bloc.onChangedText= $text');

    if (text == "" || text.length == 0) {
      _suggestionsListStreamController.sink.addError('Enter city name...');
    } else {
      try {
        _cities = await appState.api.getCities(text);

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
