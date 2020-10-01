import 'package:flutter/material.dart';
import 'package:vanilla_structured_repository/app/app_routes.dart';
import 'package:vanilla_structured_repository/data/app_state.dart';
import 'package:vanilla_structured_repository/data/repository/storage_impl_in_memory.dart';
import 'package:vanilla_structured_repository/data/service/api_impl.dart';
import 'package:vanilla_structured_repository/ui/screens/add_city_screen.dart';
import 'package:vanilla_structured_repository/ui/screens/city_detail_screen.dart';
import 'package:vanilla_structured_repository/ui/screens/home_screen.dart';

class VanillaStructuredRepositoryWeatherApp extends StatefulWidget {
  @override
  State createState() {
    return VanillaStructuredRepositoryWeatherAppState();
  }
}

class VanillaStructuredRepositoryWeatherAppState
    extends State<VanillaStructuredRepositoryWeatherApp> {
  AppState appState = AppState.loading();

  final _cities = [
    "Moscow",
    "New York",
    "London",
    "Sydney",
    "Paris",
  ];

  @override
  void initState() {
    super.initState();

    setState(() {
      appState = AppState(
        cityNames: _cities,
      );

      appState.api = MetaWeatherApi();
      appState.repo =
          StorageInMemoryImpl(appState: appState, api: appState.api);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vanilla',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(
        title: 'Vanilla Weather',
        appState: appState,
      ),
      routes: {
        // VanillaWeatherAppRoutes.home: (context) {
        //   return MyHomePage();
        // },
        VanillaWeatherAppRoutes.addCity: (context) => AddCityScreen(
              addCityName: addCityName,
              appState: appState,
            ),
        VanillaWeatherAppRoutes.cityDetail: (context) => CityDetailScreen(
              city: appState.selectedCity,
              stateImage: appState.repo.getImageForStateAbbr(
                  appState.selectedCity.weather.weatherStateAbbr),
            ),
      },
    );
  }

  void addCityName(String cityName) async {
    await appState.repo.addCity(cityName);

    setState(() {});
  }
}
