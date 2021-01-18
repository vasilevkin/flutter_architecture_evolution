import 'package:meta/meta.dart';
import 'package:redux_weather/data/repository/storage_repo.dart';
import 'package:redux_weather/redux/cities/city_state.dart';
import 'package:redux_weather/redux/suggestions/suggestion_state.dart';

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
