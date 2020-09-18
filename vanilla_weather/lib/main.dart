import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const host = 'https://www.metaweather.com/';
const api = '$host/api/location/';

void main() {
  runApp(VanillaWeatherApp());
}

class VanillaWeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vanilla',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Vanilla Weather'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final _cities = [
    "Moscow",
    "New York",
    "London",
    "Sydney",
    "Paris",
  ];

  final List<CityWeather> _citiesWeatherData = List();

  @override
  void initState() {
    super.initState();

    _loadWeatherData();
  }

  void _addCity() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
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
    for (String cityName in _cities) {
      City city = await MetaWeatherApi.getCity(cityName);
      Weather weather = await MetaWeatherApi.getWeather(city);

      print(city);
      print(weather);

      setState(() {
        _citiesWeatherData.add(CityWeather(city.name, weather.theTemp));
      });
    }
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

class MetaWeatherApi {
  static Future<City> getCity(String text) async {
    final url = '${api}search/?query=$text';
    final response = await http.get(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    final data = jsonDecode(body) as List;
    final cities = data.map((e) => City.fromJson(e)).toList();
    return cities.first;
  }

  // Future<List<City>> getCities(String text) async {
  // @override
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
