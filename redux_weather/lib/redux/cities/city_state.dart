import 'package:flutter/material.dart';
import 'package:redux_weather/app/error_messages.dart';
import 'package:redux_weather/data_models/city.dart';

@immutable
class CityState {
  final String error;
  final bool isLoading;
  final List<City> cities;

  CityState({this.error, this.isLoading, this.cities});

  factory CityState.initial() => CityState(
        error: ErrorMessages.empty,
        isLoading: false,
        cities: const [],
      );

  CityState copyWith({
    @required String error,
    @required bool isLoading,
    @required List<City> cities,
  }) {
    return CityState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      cities: cities ?? this.cities,
    );
  }
}
