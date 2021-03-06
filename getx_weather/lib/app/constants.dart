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
  static const String appTitle = 'GetX Weather';
  static const String addCityTitle = 'Add a new city';
  static const String emptyCityName = 'No Name';
  static const String editCity = 'Edit City:';
  static const String enterNewCityName = 'Please enter a new city name...';
  static const String emptyString = '';

  static const String exampleCounterTitle = 'GetX Counter demo example';
  static const String exampleCounterClicks = 'Clicks: ';
  static const String exampleCounterOther = 'Go to Other';

  static const String exampleAuthFlowTitle = 'GetX demo example';
  static const String exampleAuthFlowHomePage = 'GetX demo: Home Page';
  static const String exampleAuthFlowWelcome = 'Welcome, ';
  static const String exampleAuthFlowLogout = 'Logout';
  static const String exampleAuthFlowTestEmail = 'test@domain.com';
  static const String exampleAuthFlowTestPassword = 'password123';
  static const String exampleAuthFlowTestUserName = 'Test User';
  static const String exampleAuthFlowLogin = 'Login';
  static const String exampleAuthFlowEmail = 'Email address';
  static const String exampleAuthFlowPassword = 'Password';
  static const String exampleAuthFlowLoginButtonTitle = 'LOG IN';

  static const String exampleApiLoginTitle = 'GetX api login demo example';
  static const String exampleApiLoginDashboard = 'GetX api login Dashboard';

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
