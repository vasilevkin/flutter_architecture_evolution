import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_weather/app/app_routes.dart';
import 'package:redux_weather/app/constants.dart';
import 'package:redux_weather/data/repository/storage_repo.dart';
import 'package:redux_weather/redux/cities/city_actions.dart';
import 'package:redux_weather/redux/redux.dart';
import 'package:redux_weather/redux/store.dart';
import 'package:redux_weather/redux/suggestions/suggestion_actions.dart';
import 'package:redux_weather/redux_example/example_screen.dart';
import 'package:redux_weather/redux_example/redux/example_store.dart';
import 'package:redux_weather/scoped_models/add_or_edit_city_scoped_model.dart';
import 'package:redux_weather/scoped_models/home_scoped_model.dart';
import 'package:redux_weather/ui/screens/add_city_screen.dart';
import 'package:redux_weather/ui/screens/city_detail_screen.dart';
import 'package:redux_weather/ui/screens/edit_city_screen.dart';
import 'package:redux_weather/ui/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

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
      child: ScopedModel<HomeScopedModel>(
        model: HomeScopedModel(repo: repo),
        child: ScopedModel(
          model: AddOrEditCityScopedModel(repo: repo),
          child: _makeApp(),
        ),
      ),
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
        ReduxWeatherAppRoutes.home: (context) =>
            _makeHomeScreen(context, Constants.appTitle),
        ReduxWeatherAppRoutes.addCity: (context) => _makeAddCityScreen(context),
        ReduxWeatherAppRoutes.cityDetail: (_) => _makeCityDetailScreen(),
        ReduxWeatherAppRoutes.editCity: (_) => EditCityScreen(),
        ReduxWeatherAppRoutes.example: (_) => _makeExampleScreen(),
      },
    );
  }

  Widget _makeHomeScreen(BuildContext context, String title) {
    return HomeScreen(
      title: title,
      onInit: () {
        StoreProvider.of<AppState>(context).dispatch(LoadCitiesAction);

        Redux.store.dispatch(fetchCitiesAction);
      },
    );
  }

  Widget _makeAddCityScreen(BuildContext context) {
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
