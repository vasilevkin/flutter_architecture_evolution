import 'package:vanilla_structured_repository/model/weather.dart';

class AppState {
  bool isLoading;
  List<String> cityNames;
  CityWeather selectedCityWeather;

  AppState({
    this.isLoading = false,
    this.cityNames = const [],
  });

  factory AppState.loading() => AppState(isLoading: true);
}
