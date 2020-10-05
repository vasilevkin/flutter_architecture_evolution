import 'package:bloc_weather/app/app_routes.dart';
import 'package:bloc_weather/data/repository/storage_impl_in_memory.dart';
import 'package:bloc_weather/data/repository/storage_repo.dart';
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
  StorageRepository repo;

  @override
  void initState() {
    super.initState();
    repo = StorageInMemoryImpl(api: MetaWeatherApi());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vanilla',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        BlocWeatherAppRoutes.home: (_) => HomeScreen(repo: repo),
        BlocWeatherAppRoutes.addCity: (_) => AddCityScreen(repo: repo),
        BlocWeatherAppRoutes.cityDetail: (_) => CityDetailScreen(repo: repo),
      },
    );
  }
}
