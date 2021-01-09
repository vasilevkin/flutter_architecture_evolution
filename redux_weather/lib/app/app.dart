import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_weather/app/app_routes.dart';
import 'package:redux_weather/redux_example/example_screen.dart';
import 'package:redux_weather/redux_example/redux/store.dart';
import 'package:redux_weather/ui/screens/home_screen.dart';

class ReduxWeatherApp extends StatelessWidget {
  static const String title = 'Redux Weather';

  @override
  Widget build(BuildContext context) {
    return _makeApp();
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
        // ScopedModelWeatherAppRoutes.addCity: (_) => AddCityScreen(),
        // ScopedModelWeatherAppRoutes.cityDetail: (_) =>
        //     CityDetailScreen(repo: repo),
        // ScopedModelWeatherAppRoutes.editCity: (_) => EditCityScreen(),
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
