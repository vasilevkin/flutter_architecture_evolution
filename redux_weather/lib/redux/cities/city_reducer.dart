import 'package:redux_weather/redux/cities/city_actions.dart';
import 'package:redux_weather/redux/cities/city_state.dart';

cityReducer(CityState prevState, SetCityStateAction action) {
  final payload = action.cityState;

  return prevState.copyWith(
    isError: payload.isError,
    isLoading: payload.isLoading,
    cities: payload.cities,
  );
}
