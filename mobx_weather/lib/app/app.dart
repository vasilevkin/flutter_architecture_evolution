import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:mobx_weather/app/app_routes.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/data/repository/storage_repo.dart';
import 'package:mobx_weather/redux/cities/city_actions.dart';
import 'package:mobx_weather/redux/redux.dart';
import 'package:mobx_weather/redux/store.dart';
import 'package:mobx_weather/redux/suggestions/suggestion_actions.dart';
import 'package:mobx_weather/redux_example/example_screen.dart';
import 'package:mobx_weather/redux_example/redux/example_store.dart';
import 'package:mobx_weather/ui/screens/add_city_screen.dart';
import 'package:mobx_weather/ui/screens/city_detail_screen.dart';
import 'package:mobx_weather/ui/screens/edit_city_screen.dart';
import 'package:mobx_weather/ui/screens/home_screen.dart';

class ReduxWeatherApp extends StatelessWidget {
  final StorageRepository repo;
  final Store<AppState> store;

  ReduxWeatherApp({
    @required this.repo,
    @required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: _makeApp(),
    );
  }

  Widget _makeApp() {
    return MaterialApp(
      title: Constants.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        ReduxWeatherAppRoutes.home: (_) => _makeHomeScreen(Constants.appTitle),
        ReduxWeatherAppRoutes.addCity: (_) => _makeAddCityScreen(),
        ReduxWeatherAppRoutes.cityDetail: (_) => _makeCityDetailScreen(),
        ReduxWeatherAppRoutes.editCity: (_) => _makeEditCityScreen(),
        ReduxWeatherAppRoutes.example: (_) => _makeExampleScreen(),
      },
    );
  }

  Widget _makeHomeScreen(String title) {
    return HomeScreen(
      title: title,
      onInit: () {
        Redux.store.dispatch(fetchCitiesAction);
      },
    );
  }

  Widget _makeAddCityScreen() {
    return AddCityScreen(
      onInit: () {
        Redux.store.dispatch(fetchSuggestionsAction(Constants.emptyString));
      },
    );
  }

  Widget _makeCityDetailScreen() {
    return CityDetailScreen(
      onInit: () {
        Redux.store.dispatch(fetchSelectedCityAction);
      },
    );
  }

  Widget _makeEditCityScreen() {
    return EditCityScreen(
      onInit: () {
        Redux.store.dispatch(fetchSuggestionsAction(Constants.emptyString));
      },
    );
  }

  void exampleMain() async {
    await ExampleRedux.init();
  }

  Widget _makeExampleScreen() {
    exampleMain();

    return StoreProvider<ExampleAppState>(
      store: ExampleRedux.store,
      child: ExampleHomePage(
        title: Constants.exampleTitle,
      ),
    );
  }
}
