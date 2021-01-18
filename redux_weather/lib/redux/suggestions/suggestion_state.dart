import 'package:flutter/material.dart';
import 'package:redux_weather/data_models/city.dart';

@immutable
class SuggestionState {
  final bool isError;
  final bool isLoading;
  final List<City> suggestions;

  SuggestionState({this.isError, this.isLoading, this.suggestions});

  factory SuggestionState.initial() => SuggestionState(
        isError: false,
        isLoading: false,
        suggestions: const [],
      );

  SuggestionState copyWith({
    @required bool isError,
    @required bool isLoading,
    @required List<City> suggestions,
  }) {
    return SuggestionState(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      suggestions: suggestions ?? this.suggestions,
    );
  }
}
