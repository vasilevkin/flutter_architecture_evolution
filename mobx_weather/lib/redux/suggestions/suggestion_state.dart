import 'package:flutter/material.dart';
import 'package:mobx_weather/app/error_messages.dart';
import 'package:mobx_weather/data_models/city.dart';

@immutable
class SuggestionState {
  final String error;
  final bool isLoading;
  final List<City> suggestions;

  SuggestionState({this.error, this.isLoading, this.suggestions});

  factory SuggestionState.initial() => SuggestionState(
        error: ErrorMessages.empty,
        isLoading: false,
        suggestions: const [],
      );

  SuggestionState copyWith({
    @required String error,
    @required bool isLoading,
    @required List<City> suggestions,
  }) {
    return SuggestionState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      suggestions: suggestions ?? this.suggestions,
    );
  }
}
