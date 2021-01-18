import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:redux_weather/redux/redux.dart';
import 'package:redux_weather/redux/suggestions/suggestion_state.dart';

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
    final _cities = await repo.searchCitiesByQuery(request);

    if (_cities.isEmpty) {
      print('Redux:: suggestions are dispatched .isEmpty= ${_cities.isEmpty}');

      store.dispatch(
        SetSuggestionStateAction(
          SuggestionState(
            isLoading: false,
            isError: true,
            suggestions: null,
          ),
        ),
      );

      // _error = ArgumentError('<< City not found >>');
      // _suggestionsList = null;
    } else {
      print('Redux:: # of suggestions dispatched= ${_cities.length}');

      store.dispatch(
        SetSuggestionStateAction(
          SuggestionState(
            isLoading: false,
            isError: false,
            suggestions: _cities,
          ),
        ),
      );

      // _suggestionsList = _cities;
      // _error = null;
    }
  } catch (error) {
    print('Redux:: fetchSuggestionsAction .Error= $error');

    store.dispatch(
      SetSuggestionStateAction(
        SuggestionState(
          isLoading: false,
          isError: true,
          suggestions: null,
        ),
      ),
    );

    // _suggestionsList = null;
    // _error = ArgumentError(error.toString());
  }
}
