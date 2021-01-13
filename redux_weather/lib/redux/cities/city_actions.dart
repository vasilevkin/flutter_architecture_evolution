import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_weather/data/repository/storage_impl_in_memory.dart';
import 'package:redux_weather/data/service/api_impl.dart';
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

  final repo = StorageInMemoryImpl(api: MetaWeatherApi());

  try {
    repo.getCities.listen(
      (event) {
        store.dispatch(
          SetCityStateAction(
            CityState(
              isLoading: false,
              cities: event,
            ),
          ),
        );
        print('Redux:: cities are dispatched= $event');

        // _error = null;
        // _isLoading = false;
        // _setCitiesList(event);
      },
    ).onError(
      (error) {
        print('Redux:: cities are dispatched .Error= $error');

        store.dispatch(
            SetCityStateAction(CityState(isLoading: false, isError: true)));

        // _error = error;
        // _isLoading = false;
        // _setCitiesList(null);
      },
    );
  } catch (error) {
    print('Redux:: fetchCitiesAction .Error= $error');

    store.dispatch(
        SetCityStateAction(CityState(isLoading: false, isError: true)));
  }
}

class LoadCitiesAction {}
