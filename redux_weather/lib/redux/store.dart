import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_weather/data/repository/storage_impl_in_memory.dart';
import 'package:redux_weather/data/repository/storage_repo.dart';
import 'package:redux_weather/data/service/api_impl.dart';
import 'package:redux_weather/redux/cities/city_actions.dart';
import 'package:redux_weather/redux/cities/city_reducer.dart';
import 'package:redux_weather/redux/cities/city_state.dart';
import 'package:redux_weather/redux/suggestions/suggestion_actions.dart';
import 'package:redux_weather/redux/suggestions/suggestion_reducer.dart';
import 'package:redux_weather/redux/suggestions/suggestion_state.dart';

AppState appReducer(AppState state, dynamic action) {
  print('Redux:: appReducer action= $action');

  if (action is SetCityStateAction) {
    final nextCityState = cityReducer(state.cityState, action);

    return state.copyWith(cityState: nextCityState);
  }

  if (action is SetSuggestionStateAction) {
    final nextSuggestionState =
        suggestionReducer(state.suggestionState, action);

    return state.copyWith(suggestionState: nextSuggestionState);
  }

  return state;
}

@immutable
class AppState {
  final CityState cityState;

  final SuggestionState suggestionState;

  final StorageRepository repo;

  AppState({@required this.cityState, this.suggestionState, this.repo});

  AppState copyWith({
    CityState cityState,
    SuggestionState suggestionState,
    StorageRepository repo,
  }) {
    return AppState(
      cityState: cityState ?? this.cityState,
      suggestionState: suggestionState ?? this.suggestionState,
      repo: repo ?? this.repo,
    );
  }
}

class Redux {
  static Store<AppState> _store;
  static StorageRepository _repo;

  static Store<AppState> get store {
    if (_store == null) {
      throw Exception("Store is not initialized.");
    } else {
      return _store;
    }
  }

  static StorageRepository get repo {
    if (_repo == null) {
      throw Exception("Repo is not initialized.");
    } else {
      return _repo;
    }
  }

  static Future<void> init() async {
    final cityStateInitial = CityState.initial();

    final suggestionStateInitial = SuggestionState.initial();

    _repo = StorageInMemoryImpl(api: MetaWeatherApi());

    _store = Store<AppState>(
      appReducer,
      middleware: [thunkMiddleware],
      initialState: AppState(
        cityState: cityStateInitial,
        suggestionState: suggestionStateInitial,
        repo: repo,
      ),
    );
  }
}
