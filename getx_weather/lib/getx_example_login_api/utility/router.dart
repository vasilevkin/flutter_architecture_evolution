import 'package:get/get.dart';
import 'package:getx_weather/getx_example_login_api/view/home_view.dart';
import 'package:getx_weather/getx_example_login_api/view/login_view.dart';

class Router {
  static final route = [
    GetPage(
      name: '/loginView',
      page: () => LoginView(),
    ),
    GetPage(
      name: '/homeView',
      page: () => HomeView(),
    ),
  ];
}
