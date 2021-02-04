import 'package:flutter/material.dart';

class Constants {
  // API
  static const host = 'https://www.metaweather.com/';
  static const api = '$host/api/location/';

  // Decoration
  static const textShadows = [
    BoxShadow(
      color: Colors.black38,
      offset: Offset(3.0, 4.0),
      blurRadius: 5.0,
      spreadRadius: 15.0,
    ),
  ];

  // Strings
  static const String appTitle = 'MobX Weather';
  static const String exampleTitle = 'MobX demo example';
  static const String exampleFakeWeatherTitle = 'Fake Weather Search';
  static const String exampleGitHubTitle = 'MobX GitHub Repos demo example';
  static const String exampleChangeThemeTitle = 'MobX Theme demo example';
  static const String exampleChangeThemeSelectTheme = 'Select theme';
  static const String exampleChangeThemeLight = 'Light theme';
  static const String exampleChangeThemeDark = 'Dark theme';
  static const String exampleChangeThemeCurrent = 'The current theme is : ';
  static const String exampleChangeThemeGoToSettings = 'Go to Settings Page';
  static const String exampleChangeThemeSettings = 'Change Theme Settings';
  static const String exampleChangeThemeButton = 'Change Theme';

  static const String addCityTitle = 'Add a new city';
  static const String emptyCityName = 'No Name';
  static const String editCity = 'Edit City:';
  static const String enterNewCityName = 'Please enter a new city name...';
  static const String emptyString = '';

  static const String degreeUnit = '℃';
  static const String minTemp = 'minTemp';
  static const String maxTemp = 'maxTemp';
  static const String windCompass = 'Wind Compass';
  static const String windSpeed = 'Wind Speed';
  static const String windDirection = 'Wind Direction';
  static const String airPressure = 'Air Pressure';
  static const String humidity = 'Humidity';
  static const String visibility = 'Visibility';
  static const String predictability = 'Predictability';

  static const String initialName = '';
  static const int initialId = 0;
  static const String initialStateAbbr = 'hc';
  static const String initialDirectionCompass = 'No direction';
  static const double initialMinTemp = double.minPositive;
  static const double initialMaxTemp = double.maxFinite;
  static const double initialZero = 0.0;

  // Assets
  static const String loaderImage = 'assets/loader_image.png';
  static const String placeholderImage = 'assets/no_image.png';
}
