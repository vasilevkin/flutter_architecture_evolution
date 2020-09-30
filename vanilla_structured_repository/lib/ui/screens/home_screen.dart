import 'package:flutter/material.dart';
import 'package:vanilla_structured_repository/app/app_routes.dart';
import 'package:vanilla_structured_repository/app/constants.dart';
import 'package:vanilla_structured_repository/data/app_state.dart';
import 'package:vanilla_structured_repository/model/city.dart';
import 'package:vanilla_structured_repository/ui/widgets/home_list_item.dart';
import 'package:vanilla_structured_repository/ui/widgets/loader.dart';

class HomePage extends StatefulWidget {
  final String title;
  final AppState appState;

  HomePage({Key key, this.title, @required this.appState}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<City> _citiesData = List();

  @override
  void initState() {
    super.initState();

    _loadWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Center(
            child: _citiesData.length == 0
                ? widget.appState.isLoading
                    ? SizedBox.shrink()
                    : Text("Tap + to add city...")
                : ListView.builder(
                    itemCount: _citiesData.length,
                    itemBuilder: (context, index) {
                      final cityName = _citiesData[index].name;
                      final cityTemperature =
                          _citiesData[index].weather.theTemp;
                      final cityWeatherStateAbbr =
                          _citiesData[index].weather.weatherStateAbbr;

                      final weatherImage = Image.network(
                        '${host}static/img/weather/png/64/$cityWeatherStateAbbr.png',
                        height: 25,
                      );

                      return HomeListItem(
                        cityName: cityName,
                        temperature: cityTemperature,
                        weatherStateImage: weatherImage,
                        onTap: () => _showCityDetailScreen(_citiesData[index]),
                        onEditTap: () => _editCityItem(index),
                        onDeleteTap: () => _deleteCityItem(index),
                      );
                    },
                  ),
          ),
          widget.appState.isLoading
              ? Center(child: Loader())
              : SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCity,
        tooltip: 'Add a new city',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
      _citiesData = cities;
    });

    widget.appState.isLoading = false;
  }

  void _editCityItem(int index) {
    print("index= $index");

    widget.appState.repo.updateCity(_citiesData[index]);
  }

  void _deleteCityItem(int index) {
    widget.appState.repo.deleteCity(_citiesData[index]);
    setState(() {
      _loadWeatherData();
    });
  }
}
