import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobx_weather/app/app_routes.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/data/repository/storage_repo.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_change_theme/change_theme_home_page.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_change_theme/theme_store.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_fake_weather/pages/fake_weather_search_page.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_fake_weather/repository/fake_weather_repo.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_fake_weather/store/fake_weather_store.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_github/github_example_ui.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_reviews/example_screen.dart';
import 'package:mobx_weather/redux/cities/city_actions.dart';
import 'package:mobx_weather/redux/redux.dart';
import 'package:mobx_weather/redux/store.dart';
import 'package:mobx_weather/redux/suggestions/suggestion_actions.dart';
import 'package:mobx_weather/ui/screens/add_city_screen.dart';
import 'package:mobx_weather/ui/screens/city_detail_screen.dart';
import 'package:mobx_weather/ui/screens/edit_city_screen.dart';
import 'package:mobx_weather/ui/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

class MobxWeatherApp extends StatelessWidget {
  final StorageRepository repo;
  final Store<AppState> store;

  MobxWeatherApp({
    @required this.repo,
    @required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeStore>(
          create: (_) => ThemeStore(),
        ),
      ],
      child: StoreProvider(
        store: store,
        child: Observer(
          builder: (context) {
            return _makeApp(context);
          },
        ),
      ),
    );
  }

  Widget _makeApp(BuildContext context) {
    return MaterialApp(
      title: Constants.appTitle,
      theme: context.watch<ThemeStore>().currentThemeData,
      routes: {
        MobxWeatherAppRoutes.home: (_) => _makeHomeScreen(Constants.appTitle),
        MobxWeatherAppRoutes.addCity: (_) => _makeAddCityScreen(),
        MobxWeatherAppRoutes.cityDetail: (_) => _makeCityDetailScreen(),
        MobxWeatherAppRoutes.editCity: (_) => _makeEditCityScreen(),
        MobxWeatherAppRoutes.example: (_) => _makeExampleScreen(),
        MobxWeatherAppRoutes.exampleGitHub: (_) => _makeExampleGitHubScreen(),
        MobxWeatherAppRoutes.exampleFakeWeather: (_) =>
            _makeExampleFakeWeatherScreen(),
        MobxWeatherAppRoutes.exampleChangeTheme: (_) =>
            _makeExampleChangeThemeScreen(),
      },
    );
  }

  Widget _makeHomeScreen(String title) {
    return HomeScreen(
      title: title,
      onInit: () {
        Redux.store.dispatch(fetchCitiesAction);
      },
    );
  }

  Widget _makeAddCityScreen() {
    return AddCityScreen(
      onInit: () {
        Redux.store.dispatch(fetchSuggestionsAction(Constants.emptyString));
      },
    );
  }

  Widget _makeCityDetailScreen() {
    return CityDetailScreen(
      onInit: () {
        Redux.store.dispatch(fetchSelectedCityAction);
      },
    );
  }

  Widget _makeEditCityScreen() {
    return EditCityScreen(
      onInit: () {
        Redux.store.dispatch(fetchSuggestionsAction(Constants.emptyString));
      },
    );
  }

  Widget _makeExampleScreen() {
    return ExampleHomePage(
      title: Constants.exampleTitle,
    );
  }

  Widget _makeExampleGitHubScreen() => GithubExample();

  Widget _makeExampleFakeWeatherScreen() {
    return Provider(
      create: (context) => FakeWeatherStore(FakeWeatherRepositoryImpl()),
      child: FakeWeatherSearchPage(),
    );
  }

  Widget _makeExampleChangeThemeScreen() {
    return ChangeThemeHomePage();
  }
}
