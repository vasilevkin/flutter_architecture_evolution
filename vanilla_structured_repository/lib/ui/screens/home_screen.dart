import 'package:flutter/material.dart';
import 'package:vanilla_structured_repository/app/app_routes.dart';
import 'package:vanilla_structured_repository/app/constants.dart';
import 'package:vanilla_structured_repository/data/app_state.dart';
import 'package:vanilla_structured_repository/data/service/api_impl.dart';
import 'package:vanilla_structured_repository/model/city.dart';
import 'package:vanilla_structured_repository/model/weather.dart';

class HomePage extends StatefulWidget {
  final String title;
  final AppState appState;

  HomePage({Key key, this.title, @required this.appState}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<CityWeather> _citiesWeatherData = List();

  @override
  void initState() {
    super.initState();

    _loadWeatherData();
  }

  void _addCity() {
    Navigator.pushNamed(context, VanillaWeatherAppRoutes.addCity).then(
        (value) => _loadWeatherDataForCityName(widget.appState.cityNames.last));
  }

  void _showCityDetailScreen(CityWeather cityWeatherData) {
    widget.appState.selectedCityWeather = cityWeatherData;
    Navigator.pushNamed(context, VanillaWeatherAppRoutes.cityDetail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: ListView.builder(
        itemCount: _citiesWeatherData.length,
        itemBuilder: (context, index) {
          final cityName = _citiesWeatherData[index].city.name;
          final cityTemperature = _citiesWeatherData[index].weather.theTemp;
          final cityWeatherStateAbbr =
              _citiesWeatherData[index].weather.weatherStateAbbr;

          return Card(
            child: ListTile(
              title: Text(cityName),
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${cityTemperature.toInt()} ℃"),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Image.network(
                      '${host}static/img/weather/png/64/$cityWeatherStateAbbr.png',
                      height: 25,
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editCityItem(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteCityItem(index),
                  ),
                ],
              ),
              onTap: () => _showCityDetailScreen(_citiesWeatherData[index]),
            ),
            elevation: 10,
          );
        },
      )),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCity,
        tooltip: 'Add a new city',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _loadWeatherData() async {
    for (String cityName in widget.appState.cityNames) {
      City city = await widget.appState.api.getCity(cityName);
      Weather weather = await widget.appState.api.getWeather(city);

      setState(() {
        _citiesWeatherData.add(CityWeather(city, weather));
      });
    }
  }

  void _loadWeatherDataForCityName(String cityName) async {
    City city = await widget.appState.api.getCity(cityName);
    Weather weather = await widget.appState.api.getWeather(city);

    setState(() {
      _citiesWeatherData.add(CityWeather(city, weather));
    });
  }

  _editCityItem(int index) {}

  void _deleteCityItem(int index) {
    print("_citiesWeatherData.removeAt(index), index= $index");

    setState(() {
      _citiesWeatherData.removeAt(index);
    });
  }
}
