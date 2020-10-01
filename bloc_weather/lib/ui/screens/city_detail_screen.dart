import 'package:flutter/material.dart';
import 'package:vanilla_structured_repository/app/constants.dart';
import 'package:vanilla_structured_repository/model/city.dart';
import 'package:vanilla_structured_repository/ui/widgets/minor_weather_detail.dart';

class CityDetailScreen extends StatelessWidget {
  final City city;
  final Image stateImage;

  const CityDetailScreen({Key key, @required this.city, this.stateImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(city.name),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/background_images/${city.weather.weatherStateAbbr}.jpg',
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
                    city.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: Colors.white54,
                        shadows: textShadows),
                  ),
                  Text(
                    city.weather.applicableDate.toIso8601String(),
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
                        TweenAnimationBuilder<int>(
                          tween: IntTween(
                            begin: 0,
                            end: city.weather.theTemp.toInt(),
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
                      ],
                    ),
                  ),
                  Text(
                    city.weather.weatherStateName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      shadows: textShadows,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MinorWeatherDetail(
                        name: "minTemp",
                        value: city.weather.minTemp.toStringAsFixed(1),
                      ),
                      MinorWeatherDetail(
                        name: "maxTemp",
                        value: city.weather.maxTemp.toStringAsFixed(1),
                      ),
                    ],
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
                child: Container(
                  height: 70,
                  padding: EdgeInsets.only(top: 8),
                  child: stateImage,
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
                          value: city.weather.windSpeed.toStringAsFixed(2),
                        ),
                        MinorWeatherDetail(
                          name: "Wind Compass",
                          value: city.weather.windDirectionCompass.toString(),
                        ),
                        MinorWeatherDetail(
                          name: "Wind Direction",
                          value: city.weather.windDirection.toStringAsFixed(0),
                        ),
                        MinorWeatherDetail(
                          name: "Air Pressure",
                          value: city.weather.airPressure.toString(),
                        ),
                        MinorWeatherDetail(
                          name: "Humidity",
                          value: city.weather.humidity.toString(),
                        ),
                        MinorWeatherDetail(
                          name: "Visibility",
                          value: city.weather.visibility.toStringAsFixed(1),
                        ),
                        MinorWeatherDetail(
                          name: "Predictability",
                          value: city.weather.predictability.toString(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 70,
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
