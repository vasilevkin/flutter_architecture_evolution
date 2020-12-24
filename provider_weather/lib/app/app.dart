import 'package:provider_weather/app/app_routes.dart';
import 'package:provider_weather/data/repository/storage_impl_in_memory.dart';
import 'package:provider_weather/data/repository/storage_repo.dart';
import 'package:provider_weather/data/service/api_impl.dart';
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
    return MaterialApp(
      title: 'Provider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        BlocWeatherAppRoutes.home: (_) => HomeScreen(repo: repo),
        BlocWeatherAppRoutes.addCity: (_) => AddCityScreen(repo: repo),
        BlocWeatherAppRoutes.cityDetail: (_) => CityDetailScreen(repo: repo),
        BlocWeatherAppRoutes.editCity: (_) => EditCityScreen(repo: repo),
      },
    );
  }
}
