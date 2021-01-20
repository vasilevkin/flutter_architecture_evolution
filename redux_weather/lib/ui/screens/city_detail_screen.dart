import 'package:flutter/material.dart';
import 'package:redux_weather/app/constants.dart';
import 'package:redux_weather/data/repository/storage_repo.dart';
import 'package:redux_weather/data_models/city.dart';
import 'package:redux_weather/ui/widgets/minor_weather_detail.dart';

class CityDetailScreen extends StatelessWidget {
  final StorageRepository repo;

  final City _city;
  final Image _stateImage;

  CityDetailScreen({
    @required this.repo,
  })  : assert(repo != null),
        _city = repo.getSelectedCity(),
        _stateImage = repo.getImageForStateAbbr(
            repo.getSelectedCity()?.weather?.weatherStateAbbr ?? 'hc');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_city.name),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/background_images/${_city?.weather?.weatherStateAbbr}.jpg',
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
                    _city.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: Colors.white54,
                        shadows: Constants.textShadows),
                  ),
                  Text(
                    _city?.weather?.applicableDate?.toIso8601String() ??
                        Constants.emptyString,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white54,
                      shadows: Constants.textShadows,
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
                            end: _city.weather?.theTemp?.toInt() ?? 0,
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
                                  shadows: Constants.textShadows),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              Constants.degreeUnit,
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w800,
                                shadows: Constants.textShadows,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    _city.weather?.weatherStateName ?? Constants.emptyString,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      shadows: Constants.textShadows,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MinorWeatherDetail(
                        name: Constants.minTemp,
                        value: _city.weather?.minTemp?.toStringAsFixed(1) ??
                            Constants.emptyString,
                      ),
                      MinorWeatherDetail(
                        name: Constants.maxTemp,
                        value: _city.weather?.maxTemp?.toStringAsFixed(1) ??
                            Constants.emptyString,
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
                  child: _stateImage,
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
                          name: Constants.windSpeed,
                          value: _city.weather?.windSpeed?.toStringAsFixed(2),
                        ),
                        MinorWeatherDetail(
                          name: Constants.windCompass,
                          value:
                              _city.weather?.windDirectionCompass?.toString(),
                        ),
                        MinorWeatherDetail(
                          name: Constants.windDirection,
                          value:
                              _city.weather?.windDirection?.toStringAsFixed(0),
                        ),
                        MinorWeatherDetail(
                          name: Constants.airPressure,
                          value: _city.weather?.airPressure?.toString(),
                        ),
                        MinorWeatherDetail(
                          name: Constants.humidity,
                          value: _city.weather?.humidity?.toString(),
                        ),
                        MinorWeatherDetail(
                          name: Constants.visibility,
                          value: _city.weather?.visibility?.toStringAsFixed(1),
                        ),
                        MinorWeatherDetail(
                          name: Constants.predictability,
                          value: _city.weather?.predictability?.toString(),
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
