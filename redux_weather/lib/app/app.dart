import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_weather/app/app_routes.dart';
import 'package:redux_weather/data/repository/storage_repo.dart';
import 'package:redux_weather/redux_example/example_screen.dart';
import 'package:redux_weather/redux_example/redux/store.dart';
import 'package:redux_weather/scoped_models/add_or_edit_city_scoped_model.dart';
import 'package:redux_weather/scoped_models/home_scoped_model.dart';
import 'package:redux_weather/ui/screens/add_city_screen.dart';
import 'package:redux_weather/ui/screens/city_detail_screen.dart';
import 'package:redux_weather/ui/screens/edit_city_screen.dart';
import 'package:redux_weather/ui/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class ReduxWeatherApp extends StatelessWidget {
  static const String title = 'Redux Weather';

  final StorageRepository repo;

  ReduxWeatherApp({
    @required this.repo,
  });

  @override
  Widget build(BuildContext context) {
    return ScopedModel<HomeScopedModel>(
      model: HomeScopedModel(repo: repo),
      child: ScopedModel(
        model: AddOrEditCityScopedModel(repo: repo),
        child: _makeApp(),
      ),
    );
  }

  Widget _makeApp() {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        ReduxWeatherAppRoutes.home: (_) => HomeScreen(title: title),
        ReduxWeatherAppRoutes.addCity: (_) => AddCityScreen(),
        ReduxWeatherAppRoutes.cityDetail: (_) => CityDetailScreen(repo: repo),
        ReduxWeatherAppRoutes.editCity: (_) => EditCityScreen(),
        ReduxWeatherAppRoutes.example: (_) => _makeExampleScreen(),
      },
    );
  }

  void exampleMain() async {
    await Redux.init();
  }

  Widget _makeExampleScreen() {
    exampleMain();

    return StoreProvider<AppState>(
      store: Redux.store,
      child: ExampleHomePage(
        title: 'Redux demo example',
      ),
    );
  }
}
