import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:getx_weather/app/constants.dart';
import 'package:getx_weather/app/error_messages.dart';
import 'package:getx_weather/redux/redux.dart';
import 'package:getx_weather/redux/suggestions/suggestion_state.dart';

@immutable
class SetSuggestionStateAction {
  final SuggestionState suggestionState;

  SetSuggestionStateAction(this.suggestionState);
}

Future<void> fetchSuggestionsAction(String request) async {
  final store = Redux.store;

  print('Redux:: suggestions are started to dispatch, request= $request');

  store.dispatch(SetSuggestionStateAction(SuggestionState(isLoading: true)));

  final repo = store.state.repo;

  try {
    if (request == Constants.emptyString || request.length == 0) {
      store.dispatch(
        SetSuggestionStateAction(
          SuggestionState(
            isLoading: false,
            error: ErrorMessages.emptySearchString,
            suggestions: const [],
          ),
        ),
      );
      return;
    }

    final _cities = await repo.searchCitiesByQuery(request);

    if (_cities.isEmpty) {
      print('Redux:: suggestions are dispatched .isEmpty= ${_cities.isEmpty}');

      store.dispatch(
        SetSuggestionStateAction(
          SuggestionState(
            isLoading: false,
            error: ErrorMessages.cityNotFound,
            suggestions: const [],
          ),
        ),
      );
    } else {
      print('Redux:: # of suggestions dispatched= ${_cities.length}');

      store.dispatch(
        SetSuggestionStateAction(
          SuggestionState(
            isLoading: false,
            error: ErrorMessages.empty,
            suggestions: _cities,
          ),
        ),
      );
    }
  } catch (error) {
    print('Redux:: fetchSuggestionsAction .Error= $error');

    store.dispatch(
      SetSuggestionStateAction(
        SuggestionState(
          isLoading: false,
          error: '${ErrorMessages.unknownError} ${error.toString()}',
          suggestions: const [],
        ),
      ),
    );
  }
}
