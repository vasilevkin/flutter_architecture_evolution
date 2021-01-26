import 'package:mobx_weather/redux/cities/city_actions.dart';
import 'package:mobx_weather/redux/cities/city_state.dart';

cityReducer(CityState prevState, SetCityStateAction action) {
  final payload = action.cityState;

  return prevState.copyWith(
    error: payload.error,
    isLoading: payload.isLoading,
    cities: payload.cities,
    selectedCity: payload.selectedCity,
    stateImageForSelectedCity: payload.stateImageForSelectedCity,
  );
}
