import 'package:redux_weather/redux/cities/city_actions.dart';
import 'package:redux_weather/redux/cities/city_reducer.dart';
import 'package:redux_weather/redux/store.dart';
import 'package:redux_weather/redux/suggestions/suggestion_actions.dart';
import 'package:redux_weather/redux/suggestions/suggestion_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  print('Redux:: appReducer action= $action');

  switch (action.runtimeType) {
    case SetCityStateAction:
      final nextCityState = cityReducer(state.cityState, action);

      return state.copyWith(cityState: nextCityState);
      break;

    case SetSuggestionStateAction:
      final nextSuggestionState =
          suggestionReducer(state.suggestionState, action);

      return state.copyWith(suggestionState: nextSuggestionState);
      break;

    default:
      print('appReducer:: Unknown action: $action');
      break;
  }

  return state;
}
