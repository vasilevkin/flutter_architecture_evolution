import 'package:get/get.dart';
import 'package:getx_weather/getx_example_auth_flow/features/authentication/authentication.dart';

class HomeController extends GetxController {
  final AuthenticationController _authenticationController = Get.find();

  void signOut() {
    _authenticationController.signOut();
  }
}
