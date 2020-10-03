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

    // _loadWeatherData();
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
              return snapshot.data.length == 0
                  ? widget.appState.isLoading
                      ? SizedBox.shrink()
                      : Text("Tap + to add city...")
                  : _buildCitiesList(cities: snapshot.data);

            if (snapshot.hasError) return Text('${snapshot.error}');

            return Loader();
          },
        ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildCitiesList({List<City> cities}) {
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
          onEditTap: () => _editCityItem(cities[index]),
          onDeleteTap: () => _deleteCityItem(cities[index]),
        );
      },
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: _addCity,
      tooltip: 'Add a new city',
      child: Icon(Icons.add),
    );
  }

  void _addCity() async {
    widget.appState.isLoading = true;

    // Not a good way to update List of Cities.
    // For educational purposes only.
    // In production better use some kind of State management solution:
    // Scoped Model, BLoC, Provider, etc.
    await Navigator.pushNamed(context, VanillaWeatherAppRoutes.addCity);

    setState(() {
      _loadWeatherData();
    });

    widget.appState.isLoading = false;
  }

  void _showCityDetailScreen(City city) {
    widget.appState.selectedCity = city;
    Navigator.pushNamed(context, VanillaWeatherAppRoutes.cityDetail);
  }

  void _loadWeatherData() async {
    widget.appState.isLoading = true;

    final cities = await widget.appState.repo.getAllCities();
    setState(() {
      // _citiesData = cities;
    });

    widget.appState.isLoading = false;
  }

  void _editCityItem(City city) {
    // void _editCityItem(int index) {
    //   print("index= $index");

    widget.appState.repo.updateCity(city);
    // widget.appState.repo.updateCity(_citiesData[index]);
  }

  void _deleteCityItem(City city) {
    // void _deleteCityItem(int index) {
    widget.appState.repo.deleteCity(city);
    // widget.appState.repo.deleteCity(_citiesData[index]);
    // setState(() {
    //   _loadWeatherData();
    // });
  }
}
