import 'package:flutter/material.dart';
import 'package:vanilla_structured_repository/app/app_routes.dart';
import 'package:vanilla_structured_repository/app/constants.dart';
import 'package:vanilla_structured_repository/data/app_state.dart';
import 'package:vanilla_structured_repository/data/service/api_impl.dart';
import 'package:vanilla_structured_repository/model/city.dart';
import 'package:vanilla_structured_repository/model/weather.dart';
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
      body: Stack(
        children: [
          Center(
            child: _citiesWeatherData.length == 0
                ? widget.appState.isLoading
                    ? SizedBox.shrink()
                    : Text("Tap + to add city...")
                : ListView.builder(
                    itemCount: _citiesWeatherData.length,
                    itemBuilder: (context, index) {
                      final cityName = _citiesWeatherData[index].city.name;
                      final cityTemperature =
                          _citiesWeatherData[index].weather.theTemp;
                      final cityWeatherStateAbbr =
                          _citiesWeatherData[index].weather.weatherStateAbbr;

                      final weatherImage = Image.network(
                        '${host}static/img/weather/png/64/$cityWeatherStateAbbr.png',
                        height: 25,
                      );

                      return HomeListItem(
                        cityName: cityName,
                        temperature: cityTemperature,
                        weatherStateImage: weatherImage,
                        onTap: () =>
                            _showCityDetailScreen(_citiesWeatherData[index]),
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

  void _loadWeatherData() async {
    for (String cityName in widget.appState.cityNames) {
      widget.appState.isLoading = true;

      City city = await widget.appState.api.getCity(cityName);
      Weather weather = await widget.appState.api.getWeather(city);

      setState(() {
        _citiesWeatherData.add(CityWeather(city, weather));
      });
      widget.appState.isLoading = false;
    }
  }

  void _loadWeatherDataForCityName(String cityName) async {
    widget.appState.isLoading = true;

    City city = await widget.appState.api.getCity(cityName);
    Weather weather = await widget.appState.api.getWeather(city);

    setState(() {
      _citiesWeatherData.add(CityWeather(city, weather));
    });

    widget.appState.isLoading = false;
  }

  _editCityItem(int index) {}

  void _deleteCityItem(int index) {
    setState(() {
      _citiesWeatherData.removeAt(index);
    });
  }
}
