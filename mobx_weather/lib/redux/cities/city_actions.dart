import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/app/error_messages.dart';
import 'package:mobx_weather/data_models/city.dart';
import 'package:mobx_weather/redux/cities/city_state.dart';
import 'package:mobx_weather/redux/redux.dart';
import 'package:mobx_weather/redux/store.dart';

@immutable
class SetCityStateAction {
  final CityState cityState;

  SetCityStateAction(this.cityState);
}

Future<void> fetchCitiesAction(Store<AppState> store) async {
  await _sendAction(actionName: 'fetchCitiesAction', actionBody: () {});
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
  await _sendAction(
      actionName: 'deleteCityAction',
      actionBody: () async {
        await Redux.store.state.repo.deleteCity(city);
      });
}

Future<void> addCityAction(String name) async {
  await _sendAction(
      actionName: 'addCityAction',
      actionBody: () async {
        await Redux.store.state.repo.addCity(name);
      });
}

Future<void> updateCityAction(City city) async {
  await _sendAction(
      actionName: 'updateCityAction',
      actionBody: () async {
        await Redux.store.state.repo.updateCity(city);
      });
}

Future<void> _sendAction({
  @required String actionName,
  @required Function actionBody,
}) async {
  final store = Redux.store;

  try {
    print('Redux:: $actionName is started to dispatch');

    store.dispatch(SetCityStateAction(CityState(isLoading: true)));

    final repo = store.state.repo;

    await actionBody();

    final event = await repo.getCities();

    store.dispatch(
      SetCityStateAction(
        CityState(
          isLoading: false,
          error: ErrorMessages.empty,
          cities: event,
        ),
      ),
    );
    print(
        'Redux:: $actionName is dispatched. :: # of cities dispatched= ${event.length}');
    // print('Redux:: cities are dispatched= $event');
  } catch (error) {
    print('Redux:: $actionName .Error= $error');

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
