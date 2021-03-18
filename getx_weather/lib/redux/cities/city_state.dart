import 'package:flutter/material.dart';
import 'package:getx_weather/app/constants.dart';
import 'package:getx_weather/app/error_messages.dart';
import 'package:getx_weather/data_models/city.dart';

@immutable
class CityState {
  final String error;
  final bool isLoading;
  final List<City> cities;
  final City selectedCity;
  final Image stateImageForSelectedCity;

  CityState({
    this.error,
    this.isLoading,
    this.cities,
    this.selectedCity,
    this.stateImageForSelectedCity,
  });

  factory CityState.initial() => CityState(
        error: ErrorMessages.empty,
        isLoading: false,
        cities: const [],
        selectedCity: City.initial(),
        stateImageForSelectedCity: Image.asset(Constants.placeholderImage),
      );

  CityState copyWith({
    @required String error,
    @required bool isLoading,
    @required List<City> cities,
    @required City selectedCity,
    @required Image stateImageForSelectedCity,
  }) {
    return CityState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      cities: cities ?? this.cities,
      selectedCity: selectedCity ?? this.selectedCity,
      stateImageForSelectedCity:
          stateImageForSelectedCity ?? this.stateImageForSelectedCity,
    );
  }
}
