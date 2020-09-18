import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const host = 'https://www.metaweather.com/';
const api = '$host/api/location/';

void main() {
  runApp(VanillaWeatherApp());
}

class VanillaWeatherApp extends StatefulWidget {
  @override
  State createState() {
    return VanillaWeatherAppState();
  }
}

class VanillaWeatherAppState extends State<VanillaWeatherApp> {
  AppState appState = AppState.loading();

  final _cities = [
    "Moscow",
    "New York",
    "London",
    "Sydney",
    "Paris",
  ];

  @override
  void initState() {
    super.initState();

    setState(() {
      appState = AppState(
        cityNames: _cities,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vanilla',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        title: 'Vanilla Weather',
        appState: appState,
      ),
      routes: {
        // VanillaWeatherAppRoutes.home: (context) {
        //   return MyHomePage();
        // },
        VanillaWeatherAppRoutes.addCity: (context) {
          return AddCityScreen(
            addCityName: addCityName,
          );
        },
      },
    );
  }

  void addCityName(String cityName) {
    setState(() {
      appState.cityNames.add(cityName);
    });
  }
}

class AppState {
  bool isLoading;
  List<String> cityNames;

  AppState({
    this.isLoading = false,
    this.cityNames = const [],
  });

  factory AppState.loading() => AppState(isLoading: true);
}

class MyHomePage extends StatefulWidget {
  final String title;
  final AppState appState;

  MyHomePage({Key key, this.title, @required this.appState}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<CityWeather> _citiesWeatherData = List();

  @override
  void initState() {
    super.initState();

    _loadWeatherData();
  }

  void _addCity() {
    Navigator.pushNamed(context, VanillaWeatherAppRoutes.addCity)
        .then((value) => _loadWeatherData());
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
          final cityName = _citiesWeatherData[index].name;
          final cityTemperature = _citiesWeatherData[index].temperature;
          return Card(
            child: ListTile(
              title: Text(cityName),
              trailing: Text("$cityTemperature ℃"),
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
      City city = await MetaWeatherApi.getCity(cityName);
      Weather weather = await MetaWeatherApi.getWeather(city);

      setState(() {
        _citiesWeatherData.add(CityWeather(city.name, weather.theTemp));
      });
    }
  }
}

class AddCityScreen extends StatefulWidget {
  final Function(String name) addCityName;

  AddCityScreen({
    @required this.addCityName,
  });

  @override
  _AddCityScreenState createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new City"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
            key: formKey,
            autovalidate: false,
            child: ListView(
              children: [
                TextFormField(
                  onSaved: (value) => _cityName = value,
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            final form = formKey.currentState;
            if (form.validate()) {
              form.save();

              final cityName = _cityName;

              widget.addCityName(cityName);
              Navigator.pop(context);
            }
          }),
    );
  }
}

class City {
  final String name;
  final int woeId;

  City({
    this.name,
    this.woeId,
  });

  factory City.fromJson(Map<String, dynamic> map) {
    return City(
      name: map['title'],
      woeId: map['woeid'],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": name,
        "woeid": woeId,
      };

  @override
  String toString() {
    return 'City{name: $name, woeId: $woeId}';
  }
}

class CityWeather {
  final String name;
  final double temperature;

  CityWeather(
    this.name,
    this.temperature,
  );
}

class Weather {
  int id;
  double theTemp;

  Weather({
    this.id,
    this.theTemp,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        theTemp: json["the_temp"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "the_temp": theTemp,
      };

  @override
  String toString() {
    return 'Weather{id: $id, theTemp: $theTemp}';
  }
}

//region API methods
class MetaWeatherApi {
  static Future<City> getCity(String text) async {
    final url = '${api}search/?query=$text';
    final response = await http.get(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    final data = jsonDecode(body) as List;
    final cities = data.map((e) => City.fromJson(e)).toList();
    return cities.first;
  }

  static Future<Weather> getWeather(City city) async {
    final url = '$api${city.woeId}';
    final response = await http.get(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    final data = jsonDecode(body);
    final weatherData = data['consolidated_weather'] as List;
    final weatherList = weatherData.map((e) => Weather.fromJson(e)).toList();
    return weatherList.first;
  }
}
//endregion

//region AppRoutes
class VanillaWeatherAppRoutes {
  static final home = '/';
  static final addCity = '/addCity';
}
//endregion
