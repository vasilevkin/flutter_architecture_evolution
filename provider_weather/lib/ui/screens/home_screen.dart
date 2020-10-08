import 'package:provider_weather/app/app_routes.dart';
import 'package:provider_weather/bloc/home_bloc.dart';
import 'package:provider_weather/data/repository/storage_repo.dart';
import 'package:provider_weather/model/city.dart';
import 'package:provider_weather/ui/widgets/home_list_item.dart';
import 'package:provider_weather/ui/widgets/loader.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final StorageRepository repo;

  HomeScreen({
    @required this.repo,
  }) : assert(repo != null);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = HomeBloc(widget.repo);
  }

  @override
  void dispose() {
    homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Provider Weather')),
      body: Center(
        child: StreamBuilder<List<City>>(
          stream: homeBloc.citiesList,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return _buildCitiesList(cities: snapshot.data);

            if (snapshot.hasError) return Text('${snapshot.error}');

            return Loader();
          },
        ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildCitiesList({List<City> cities}) {
    if (cities.length == 0) return Text('Tap + to add a new city...');

    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final cityWeatherStateAbbr = cities[index].weather.weatherStateAbbr;
        final weatherImage =
            widget.repo.getImageForStateAbbr(cityWeatherStateAbbr);

        return HomeListItem(
          cityName: cities[index].name,
          temperature: cities[index].weather.theTemp,
          weatherStateImage: weatherImage,
          onTap: () => _showCityDetailScreen(cities[index]),
          onEditTap: () => _showEditCityScreen(cities[index]),
          onDeleteTap: () => homeBloc.deleteCity(cities[index]),
        );
      },
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: _tapAddCity,
      tooltip: 'Add a new city',
      child: Icon(Icons.add),
    );
  }

  void _tapAddCity() async {
    Navigator.pushNamed(context, BlocWeatherAppRoutes.addCity);
  }

  void _showCityDetailScreen(City city) {
    widget.repo.setSelectedCity(city);
    Navigator.pushNamed(context, BlocWeatherAppRoutes.cityDetail);
  }

  void _showEditCityScreen(City city) {
    widget.repo.setSelectedCity(city);
    Navigator.pushNamed(context, BlocWeatherAppRoutes.editCity);
  }
}
