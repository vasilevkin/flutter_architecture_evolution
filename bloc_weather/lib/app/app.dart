import 'package:bloc_weather/app/app_routes.dart';
import 'package:bloc_weather/data/app_state.dart';
import 'package:bloc_weather/data/repository/storage_impl_in_memory.dart';
import 'package:bloc_weather/data/service/api_impl.dart';
import 'package:bloc_weather/ui/screens/add_city_screen.dart';
import 'package:bloc_weather/ui/screens/city_detail_screen.dart';
import 'package:bloc_weather/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

class BlocWeatherApp extends StatefulWidget {
  @override
  State createState() {
    return BlocWeatherAppState();
  }
}

class BlocWeatherAppState extends State<BlocWeatherApp> {
  AppState appState;

  @override
  void initState() {
    super.initState();

    setState(() {
      appState = AppState();
      appState.repo = StorageInMemoryImpl(api: MetaWeatherApi());
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
        BlocWeatherAppRoutes.addCity: (context) => AddCityScreen(
              appState: appState,
            ),
        BlocWeatherAppRoutes.cityDetail: (context) => CityDetailScreen(
              city: appState.repo.getSelectedCity(),
              stateImage: appState.repo.getImageForStateAbbr(
                  appState.repo.getSelectedCity().weather.weatherStateAbbr),
            ),
      },
    );
  }
}
