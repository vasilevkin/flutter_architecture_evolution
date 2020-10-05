import 'package:bloc_weather/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bloc_weather/app/app_routes.dart';
import 'package:bloc_weather/data/app_state.dart';
import 'package:bloc_weather/model/city.dart';
import 'package:bloc_weather/ui/widgets/home_list_item.dart';
import 'package:bloc_weather/ui/widgets/loader.dart';

class HomePage extends StatefulWidget {
  final String title;
  final AppState appState;

  HomePage({Key key, this.title, @required this.appState}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = HomeBloc(widget.appState.repo);
  }

  @override
  void dispose() {
    homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
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
            widget.appState.repo.getImageForStateAbbr(cityWeatherStateAbbr);

        return HomeListItem(
          cityName: cities[index].name,
          temperature: cities[index].weather.theTemp,
          weatherStateImage: weatherImage,
          onTap: () => _showCityDetailScreen(cities[index]),
          onEditTap: () => homeBloc.editCity(cities[index]),
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
    widget.appState.selectedCity = city;
    Navigator.pushNamed(context, BlocWeatherAppRoutes.cityDetail);
  }
}
