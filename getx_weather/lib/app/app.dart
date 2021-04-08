import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:get/get.dart';
import 'package:getx_weather/app/app_routes.dart';
import 'package:getx_weather/app/constants.dart';
import 'package:getx_weather/data/repository/storage_repo.dart';
import 'package:getx_weather/getx_example_auth_flow/features/features.dart';
import 'package:getx_weather/getx_example_counter/home_counter.dart';
import 'package:getx_weather/redux/cities/city_actions.dart';
import 'package:getx_weather/redux/redux.dart';
import 'package:getx_weather/redux/store.dart';
import 'package:getx_weather/redux/suggestions/suggestion_actions.dart';
import 'package:getx_weather/ui/screens/add_city_screen.dart';
import 'package:getx_weather/ui/screens/city_detail_screen.dart';
import 'package:getx_weather/ui/screens/edit_city_screen.dart';
import 'package:getx_weather/ui/screens/home_screen.dart';
import 'package:redux/redux.dart';

class GetxWeatherApp extends StatelessWidget {
  final StorageRepository repo;
  final Store<AppState> store;

  GetxWeatherApp({
    @required this.repo,
    @required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: _makeApp(),
    );
  }

  Widget _makeApp() {
    return GetMaterialApp(
      title: Constants.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        GetxWeatherAppRoutes.home: (_) => _makeHomeScreen(Constants.appTitle),
        GetxWeatherAppRoutes.addCity: (_) => _makeAddCityScreen(),
        GetxWeatherAppRoutes.cityDetail: (_) => _makeCityDetailScreen(),
        GetxWeatherAppRoutes.editCity: (_) => _makeEditCityScreen(),
        GetxWeatherAppRoutes.exampleAuthFlow: (_) => _makeExampleAuthScreen(),
        GetxWeatherAppRoutes.exampleCounter: (_) => _makeExampleCounterScreen(),
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

  Widget _makeExampleAuthScreen() {
    initialize();

    AuthenticationController controller = Get.find();

    return Obx(() {
      if (controller.state is UnAuthenticated) {
        return LoginPage();
      }
      if (controller.state is Authenticated) {
        return HomePage(user: (controller.state as Authenticated).user);
      }
      return SplashScreen();
    });
  }

  Widget _makeExampleCounterScreen() {
    return HomeCounter();
  }

  void initialize() => Get.lazyPut(
        () => AuthenticationController(Get.put(FakeAuthenticationService())),
      );
}
