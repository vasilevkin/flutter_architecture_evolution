import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_model_weather/app/app_routes.dart';
import 'package:scoped_model_weather/data/repository/storage_repo.dart';
import 'package:scoped_model_weather/ui/screens/add_city_screen.dart';
import 'package:scoped_model_weather/ui/screens/city_detail_screen.dart';
import 'package:scoped_model_weather/ui/screens/edit_city_screen.dart';
import 'package:scoped_model_weather/ui/screens/home_screen.dart';
import 'package:scoped_model_weather/view_models/add_or_edit_city_viewmodel.dart';
import 'package:scoped_model_weather/view_models/home_viewmodel.dart';

class ScopedModelWeatherApp extends StatelessWidget {
  final StorageRepository repo;

  ScopedModelWeatherApp({
    @required this.repo,
  });

  @override
  Widget build(BuildContext context) {
    return ScopedModel<HomeScopedModel>(
      model: HomeScopedModel(repo: repo),
      child: ScopedModel(
        model: AddOrEditCityViewModel(repo: repo),
        child: _makeApp(),
      ),
    );
  }

  Widget _makeApp() {
    return MaterialApp(
      title: 'Scoped Model',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        ScopedModelWeatherAppRoutes.home: (_) => HomeScreen(),
        ScopedModelWeatherAppRoutes.addCity: (_) => AddCityScreen(),
        ScopedModelWeatherAppRoutes.cityDetail: (_) =>
            CityDetailScreen(repo: repo),
        ScopedModelWeatherAppRoutes.editCity: (_) => EditCityScreen(),
      },
    );
  }
}
