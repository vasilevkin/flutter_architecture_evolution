import 'package:flutter/material.dart';

class Constants {
  // API
  static const host = 'https://www.metaweather.com/';
  static const api = '$host/api/location/';

  static const String exampleApiCallsPostsEndpoint =
      'https://jsonplaceholder.typicode.com/posts';
  static const String exampleApiCallsUsersEndpoint =
      'https://reqres.in/api/users?page=1';

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

  static const String exampleApiCallsTitle = 'MobX api calls demo example';
  static const String exampleApiCallsPosts = 'Posts';
  static const String exampleApiCallsUsers = 'Users';
  static const String exampleApiCallsRetry = 'Tap to retry';

  static const String exampleCounterTitle = 'MobX Counter demo example';
  static const String exampleCounterText =
      'You have pushed the button this many times:';
  static const String exampleCounterTooltip = 'Increment';

  static const String exampleMultiCounterTitle =
      'MobX Multi Counter demo example';
  static const String exampleMultiCounterAdd = 'Add Counter';
  static const String exampleMultiCounterCount = 'Count:';
  static const String exampleMultiCounterReset = 'Reset';
  static const String exampleMultiCounterDetails = 'Counter details';

  static const String exampleClockTitle = 'MobX clock demo example';
  static const String exampleClockAtom = 'Clock Atom';
  static const String exampleClockStarted = 'Clock:: clock started ticking';
  static const String exampleClockStopped = 'Clock:: clock stopped ticking';

  static const String exampleTodosTitle = 'MobX ToDos demo example';
  static const String exampleTodosAddTodo = 'Add a new todo';
  static const String exampleTodosAll = 'All';
  static const String exampleTodosPending = 'Pending';
  static const String exampleTodosCompleted = 'Completed';
  static const String exampleTodosRemoveCompleted = 'Remove Completed';
  static const String exampleTodosMarkCompleted = 'Mark All Completed';
  static const String exampleTodosNoTodos =
      "There are no Todos here. Why don't you add one?";
  static const String exampleTodosTodo = 'todo';
  static const String exampleTodosTodos = 'todos';

  static const String exampleHackerNewsTitle = 'MobX Hacker news demo example';
  static const String exampleHackerNewsNewest = 'Newest';
  static const String exampleHackerNewsTop = 'Top';
  static const String exampleHackerNewsLoading = 'Loading items...';
  static const String exampleHackerNewsTapToTry = 'Tap to try again';
  static const String exampleHackerNewsComments = 'comments(s)';

  static const String exampleRandomNumberStreamTitle =
      'MobX Rundom number stream demo example';
  static const String exampleRandomNumberRandomNumber = 'Rundom number';

  static const String exampleDiceTitle = 'MobX Dice demo example';
  static const String exampleDiceTap = 'Tap the dice !!!';
  static const String exampleDiceTotal = 'Total';

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
