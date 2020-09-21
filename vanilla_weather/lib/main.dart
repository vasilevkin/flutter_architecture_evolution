import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const host = 'https://www.metaweather.com/';
const api = '$host/api/location/';

const textShadows = [
  BoxShadow(
    color: Colors.black38,
    offset: Offset(3.0, 4.0),
    blurRadius: 5.0,
    spreadRadius: 15.0,
  ),
];

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
      home: HomePage(
        title: 'Vanilla Weather',
        appState: appState,
      ),
      routes: {
        // VanillaWeatherAppRoutes.home: (context) {
        //   return MyHomePage();
        // },
        VanillaWeatherAppRoutes.addCity: (context) => AddCityScreen(
              addCityName: addCityName,
            ),
        VanillaWeatherAppRoutes.cityDetail: (context) => CityDetailScreen(
              cityWeather: appState.selectedCityWeather,
            ),
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
  CityWeather selectedCityWeather;

  AppState({
    this.isLoading = false,
    this.cityNames = const [],
  });

  factory AppState.loading() => AppState(isLoading: true);
}

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
      City city = await MetaWeatherApi.getCity(cityName);
      Weather weather = await MetaWeatherApi.getWeather(city);

      setState(() {
        _citiesWeatherData.add(CityWeather(city, weather));
      });
    }
  }

  void _loadWeatherDataForCityName(String cityName) async {
    City city = await MetaWeatherApi.getCity(cityName);
    Weather weather = await MetaWeatherApi.getWeather(city);

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

class CityDetailScreen extends StatelessWidget {
  final CityWeather cityWeather;

  const CityDetailScreen({Key key, @required this.cityWeather})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cityWeather.city.name),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/background_images/${cityWeather.weather.weatherStateAbbr}.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    cityWeather.city.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: Colors.white54,
                        shadows: textShadows),
                  ),
                  Text(
                    cityWeather.weather.applicableDate.toIso8601String(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white54,
                      shadows: textShadows,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Align(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MinorWeatherDetail(
                          name: "minTemp",
                          value: cityWeather.weather.minTemp.toString(),
                        ),
                        TweenAnimationBuilder<int>(
                          tween: IntTween(
                            begin: 0,
                            end: cityWeather.weather.theTemp.toInt(),
                          ),
                          duration: const Duration(milliseconds: 1500),
                          builder: (context, value, child) {
                            return Text(
                              value.toString(),
                              textAlign: TextAlign.center,
                              // "${}°C",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 70,
                                  shadows: textShadows),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "°C",
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w800,
                                shadows: textShadows,
                              ),
                            ),
                          ),
                        ),
                        MinorWeatherDetail(
                          name: "maxTemp",
                          value: cityWeather.weather.maxTemp.toString(),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    cityWeather.weather.weatherStateName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      shadows: textShadows,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.network(
                  '${host}static/img/weather/png/64/${cityWeather.weather.weatherStateAbbr}.png',
                  height: 40,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                      children: [
                        MinorWeatherDetail(
                          name: "Wind Speed",
                          value: cityWeather.weather.windSpeed.toString(),
                        ),
                        MinorWeatherDetail(
                          name: "Wind Compass",
                          value: cityWeather.weather.windDirectionCompass
                              .toString(),
                        ),
                        MinorWeatherDetail(
                          name: "Wind Direction",
                          value: cityWeather.weather.windDirection.toString(),
                        ),
                        MinorWeatherDetail(
                          name: "Air Pressure",
                          value: cityWeather.weather.airPressure.toString(),
                        ),
                        MinorWeatherDetail(
                          name: "Humidity",
                          value: cityWeather.weather.humidity.toString(),
                        ),
                        MinorWeatherDetail(
                          name: "Visibility",
                          value: cityWeather.weather.visibility.toString(),
                        ),
                        MinorWeatherDetail(
                          name: "predictability",
                          value: cityWeather.weather.predictability.toString(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context)),
    );
  }
}

class MinorWeatherDetail extends StatelessWidget {
  final String name;
  final String value;

  const MinorWeatherDetail({this.name, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          name,
          style: TextStyle(color: Colors.white54, shadows: textShadows),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white54,
            shadows: textShadows,
          ),
        ),
      ],
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
  final City city;
  final Weather weather;

  CityWeather(
    this.city,
    this.weather,
  );
}

class Weather {
  int id;
  String weatherStateName;
  String weatherStateAbbr;
  String windDirectionCompass;
  DateTime created;
  DateTime applicableDate;
  double minTemp;
  double maxTemp;
  double theTemp;
  double windSpeed;
  double windDirection;
  double airPressure;
  num humidity;
  double visibility;
  int predictability;

  Weather(
      {this.id,
      this.weatherStateName,
      this.weatherStateAbbr,
      this.windDirectionCompass,
      this.created,
      this.applicableDate,
      this.minTemp,
      this.maxTemp,
      this.theTemp,
      this.windSpeed,
      this.windDirection,
      this.airPressure,
      this.humidity,
      this.visibility,
      this.predictability});

  Weather.onlyTemp({
    this.id,
    this.theTemp,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        weatherStateName: json["weather_state_name"],
        weatherStateAbbr: json["weather_state_abbr"],
        windDirectionCompass: json["wind_direction_compass"],
        created: DateTime.parse(json["created"]),
        applicableDate: DateTime.parse(json["applicable_date"]),
        minTemp: json["min_temp"].toDouble(),
        maxTemp: json["max_temp"].toDouble(),
        theTemp: json["the_temp"].toDouble(),
        windSpeed: json["wind_speed"].toDouble(),
        windDirection: json["wind_direction"].toDouble(),
        airPressure: json["air_pressure"],
        humidity: json["humidity"],
        visibility: json["visibility"].toDouble(),
        predictability: json["predictability"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "weather_state_name": weatherStateName,
        "weather_state_abbr": weatherStateAbbr,
        "wind_direction_compass": windDirectionCompass,
        "created": created.toIso8601String(),
        "applicable_date":
            "${applicableDate.year.toString().padLeft(4, '0')}-${applicableDate.month.toString().padLeft(2, '0')}-${applicableDate.day.toString().padLeft(2, '0')}",
        "min_temp": minTemp,
        "max_temp": maxTemp,
        "the_temp": theTemp,
        "wind_speed": windSpeed,
        "wind_direction": windDirection,
        "air_pressure": airPressure,
        "humidity": humidity,
        "visibility": visibility,
        "predictability": predictability,
      };

  @override
  String toString() {
    return 'Weather{id: $id, weatherStateName: $weatherStateName, weatherStateAbbr: $weatherStateAbbr, windDirectionCompass: $windDirectionCompass, created: $created, applicableDate: $applicableDate, minTemp: $minTemp, maxTemp: $maxTemp, theTemp: $theTemp, windSpeed: $windSpeed, windDirection: $windDirection, airPressure: $airPressure, humidity: $humidity, visibility: $visibility, predictability: $predictability}';
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
  static final cityDetail = '/cityDetail';
}
//endregion
