import 'package:redux_weather/redux/suggestions/suggestion_actions.dart';
import 'package:redux_weather/redux/suggestions/suggestion_state.dart';

suggestionReducer(SuggestionState prevState, SetSuggestionStateAction action) {
  final payload = action.suggestionState;

  return prevState.copyWith(
    error: payload.error,
    isLoading: payload.isLoading,
    suggestions: payload.suggestions,
  );
}
