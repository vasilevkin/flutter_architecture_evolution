import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_weather/app/constants.dart';
import 'package:redux_weather/app/error_messages.dart';
import 'package:redux_weather/data_models/city.dart';
import 'package:redux_weather/redux/cities/city_state.dart';
import 'package:redux_weather/redux/redux.dart';
import 'package:redux_weather/redux/store.dart';

@immutable
class SetCityStateAction {
  final CityState cityState;

  SetCityStateAction(this.cityState);
}

Future<void> fetchCitiesAction(Store<AppState> store) async {
  print('Redux:: fetch cities are started to dispatch');

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

Future<void> fetchSelectedCityAction(Store<AppState> store) async {
  print('Redux:: fetch selected city is started to dispatch');

  store.dispatch(SetCityStateAction(CityState(isLoading: true)));

  final repo = store.state.repo;

  try {
    final _city = repo.getSelectedCity();
    final Image _stateImage =
        repo.getImageForStateAbbr(_city?.weather?.weatherStateAbbr ?? 'hc');

    store.dispatch(
      SetCityStateAction(
        CityState(
          isLoading: false,
          error: ErrorMessages.empty,
          selectedCity: _city,
          stateImageForSelectedCity: _stateImage,
        ),
      ),
    );
    print('Redux:: fetch selected city is dispatched= $_city');
    print('Redux:: stateImageForSelectedCity is dispatched= $_stateImage');
  } catch (error) {
    print('Redux:: fetchSelectedCityAction .Error= $error');

    store.dispatch(
      SetCityStateAction(
        CityState(
          isLoading: false,
          error: '${ErrorMessages.unknownError} ${error.toString()}',
          selectedCity: City.initial(),
          stateImageForSelectedCity: Image.asset(Constants.placeholderImage),
        ),
      ),
    );
  }
}

Future<void> setSelectedCityAction(City city) async {
  final store = Redux.store;

  print('Redux:: set selected city is started to dispatch');

  store.dispatch(SetCityStateAction(CityState(isLoading: true)));

  final repo = store.state.repo;

  try {
    repo.setSelectedCity(city);
    store.dispatch(
      SetCityStateAction(
        CityState(
          isLoading: false,
          error: ErrorMessages.empty,
          selectedCity: city,
        ),
      ),
    );
    print('Redux:: set selected city is dispatched. city= $city');
  } catch (error) {
    print('Redux:: setSelectedCityAction .Error= $error');

    store.dispatch(
      SetCityStateAction(
        CityState(
          isLoading: false,
          error: '${ErrorMessages.unknownError} ${error.toString()}',
          selectedCity: City.initial(),
          stateImageForSelectedCity: Image.asset(Constants.placeholderImage),
        ),
      ),
    );
  }
}

Future<void> deleteCityAction(City city) async {
  final store = Redux.store;

  print('Redux:: delete city is started to dispatch');

  store.dispatch(SetCityStateAction(CityState(isLoading: true)));

  final repo = store.state.repo;

  try {
    await repo.deleteCity(city);
    print('Redux:: deleteCityAction is dispatched. city= $city');
  } catch (error) {
    print('Redux:: deleteCityAction .Error= $error');
  }
}

class LoadCitiesAction {}
