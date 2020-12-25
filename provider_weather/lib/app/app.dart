import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_weather/app/app_routes.dart';
import 'package:provider_weather/data/repository/storage_repo.dart';
import 'package:provider_weather/ui/screens/add_city_screen.dart';
import 'package:provider_weather/ui/screens/city_detail_screen.dart';
import 'package:provider_weather/ui/screens/edit_city_screen.dart';
import 'package:provider_weather/ui/screens/home_screen.dart';
import 'package:provider_weather/view_models/add_city_viewmodel.dart';
import 'package:provider_weather/view_models/home_viewmodel.dart';

class ProviderWeatherApp extends StatelessWidget {
  final StorageRepository repo;

  ProviderWeatherApp({
    @required this.repo,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
          create: (_) => HomeViewModel(repo: repo)..loadCitiesList(),
        ),
        Provider(
          create: (_) => AddCityViewModel(repo),
        ),
      ],
      child: _makeApp(),
    );
  }

  Widget _makeApp() {
    return MaterialApp(
      title: 'Provider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        ProviderWeatherAppRoutes.home: (_) => HomeScreen(),
        ProviderWeatherAppRoutes.addCity: (_) => AddCityScreen(),
        ProviderWeatherAppRoutes.cityDetail: (_) =>
            CityDetailScreen(repo: repo),
        ProviderWeatherAppRoutes.editCity: (_) => EditCityScreen(repo: repo),
      },
    );
  }
}
