import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_weather/redux/cities/city_actions.dart';
import 'package:redux_weather/redux/cities/city_reducer.dart';
import 'package:redux_weather/redux/cities/city_state.dart';
import 'package:redux_weather/redux_example/redux/posts/post_actions.dart';
import 'package:redux_weather/redux_example/redux/posts/post_reducer.dart';
import 'package:redux_weather/redux_example/redux/posts/post_state.dart';

AppState AppReducer(AppState state, dynamic action) {
  if (action is SetCityStateAction) {
    final nextCityState = cityReducer(state.cityState, action);

    return state.copyWith(cityState: nextCityState);
  }

  return state;
}

@immutable
class AppState {
  final CityState cityState;

  AppState({@required this.cityState});

  AppState copyWith({CityState cityState}) {
    return AppState(cityState: cityState ?? this.cityState);
  }
}

class Redux {
  static Store<AppState> _store;

  static Store<AppState> get store {
    if (_store == null) {
      throw Exception("Store is not initialized.");
    } else {
      return _store;
    }
  }

  static Future<void> init() async {
    final cityStateInitial = CityState.initial();

    _store = Store<AppState>(
      AppReducer,
      middleware: [thunkMiddleware],
      initialState: AppState(cityState: cityStateInitial),
    );
  }
}
