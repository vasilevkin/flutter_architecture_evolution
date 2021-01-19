import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_weather/app/error_messages.dart';
import 'package:redux_weather/redux/cities/city_state.dart';
import 'package:redux_weather/redux/store.dart';

@immutable
class SetCityStateAction {
  final CityState cityState;

  SetCityStateAction(this.cityState);
}

Future<void> fetchCitiesAction(Store<AppState> store) async {
  print('Redux:: cities are started to dispatch');

  store.dispatch(SetCityStateAction(CityState(isLoading: true)));

  final repo = store.state.repo;

  try {
    repo.getCities.listen(
      (event) {
        store.dispatch(
          SetCityStateAction(
            CityState(
              isLoading: false,
              error: ErrorMessages.empty,
              cities: event,
            ),
          ),
        );
        print('Redux:: # of cities dispatched= ${event.length}');
        // print('Redux:: cities are dispatched= $event');
      },
    ).onError(
      (error) {
        print('Redux:: cities are dispatched .Error= $error');

        store.dispatch(
          SetCityStateAction(
            CityState(
              isLoading: false,
              error: '${ErrorMessages.failedFetchCities} ${error.toString()}',
              cities: const [],
            ),
          ),
        );
      },
    );
  } catch (error) {
    print('Redux:: fetchCitiesAction .Error= $error');

    store.dispatch(
      SetCityStateAction(
        CityState(
          isLoading: false,
          error: '${ErrorMessages.unknownError} ${error.toString()}',
          cities: const [],
        ),
      ),
    );
  }
}

class LoadCitiesAction {}
