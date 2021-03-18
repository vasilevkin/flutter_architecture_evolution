import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:getx_weather/app/constants.dart';
import 'package:getx_weather/app/error_messages.dart';
import 'package:getx_weather/data_models/city.dart';
import 'package:getx_weather/redux/cities/city_state.dart';
import 'package:getx_weather/redux/store.dart';
import 'package:getx_weather/ui/widgets/loader.dart';
import 'package:getx_weather/ui/widgets/minor_weather_detail.dart';

class CityDetailScreen extends StatelessWidget {
  final void Function() onInit;

  CityDetailScreen({@required this.onInit});

  @override
  Widget build(BuildContext context) {
    onInit();

    return StoreConnector<AppState, CityState>(
      distinct: true,
      converter: (store) => store.state.cityState,
      builder: (context, cityState) {
        final _city = cityState.selectedCity;
        final _stateImage = cityState.stateImageForSelectedCity;

        print('CityDetailScreen:: _city= $_city');
        print('CityDetailScreen:: _stateImage= $_stateImage');

        if (_city.name == null) return Loader();

        if (cityState == null || cityState.isLoading) {
          return Center(child: Loader());
        }
        if (cityState.error != ErrorMessages.empty) {
          return _buildErrorMessage(text: cityState.error);
        }
        return _buildBody(context, _city, _stateImage);
      },
    );
  }

  Widget _buildBody(BuildContext context, City _city, Image _stateImage) {
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

  Widget _buildErrorMessage({String text}) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Text(text, style: TextStyle(color: Colors.redAccent)),
    );
  }
}
