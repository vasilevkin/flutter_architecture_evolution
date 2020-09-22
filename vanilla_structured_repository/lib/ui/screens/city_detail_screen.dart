
import 'package:flutter/material.dart';
import 'package:vanilla_structured_repository/app/constants.dart';
import 'package:vanilla_structured_repository/model/weather.dart';
import 'package:vanilla_structured_repository/ui/widgets/minor_weather_detail.dart';

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
