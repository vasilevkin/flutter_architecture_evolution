import 'package:provider/provider.dart';
import 'package:provider_weather/app/app_routes.dart';
import 'package:provider_weather/data/repository/storage_impl_in_memory.dart';
import 'package:provider_weather/data/repository/storage_repo.dart';
import 'package:provider_weather/data/service/api_impl.dart';
import 'package:provider_weather/data_models/city.dart';
import 'package:provider_weather/model/home_viewmodel.dart';
import 'package:provider_weather/ui/screens/add_city_screen.dart';
import 'package:provider_weather/ui/screens/city_detail_screen.dart';
import 'package:provider_weather/ui/screens/edit_city_screen.dart';
import 'package:provider_weather/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

class ProviderWeatherApp extends StatelessWidget {
  final StorageRepository repo;

  ProviderWeatherApp({
    @required this.repo,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(repo: repo)..loadCitiesList(),
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
        ProviderWeatherAppRoutes.addCity: (_) => AddCityScreen(repo: repo),
        ProviderWeatherAppRoutes.cityDetail: (_) => CityDetailScreen(repo: repo),
        ProviderWeatherAppRoutes.editCity: (_) => EditCityScreen(repo: repo),
      },
    );
  }
}
