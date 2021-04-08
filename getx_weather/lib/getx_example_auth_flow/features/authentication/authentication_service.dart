import 'package:get/get.dart';
import 'package:getx_weather/app/constants.dart';
import 'package:getx_weather/app/error_messages.dart';
import 'package:getx_weather/getx_example_auth_flow/models/models.dart';

abstract class AuthenticationService extends GetxService {
  Future<User> getCurrentUser();

  Future<User> signInWithEmailAndPassword(String email, String password);

  Future<void> signOut();
}

class FakeAuthenticationService extends AuthenticationService {
  @override
  Future<User> getCurrentUser() async {
    await Future.delayed(Duration(seconds: 2));
    return null;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));

    if (email.toLowerCase() != Constants.exampleAuthFlowTestEmail ||
        password != Constants.exampleAuthFlowTestPassword) {
      throw AuthenticationException(
          message: ErrorMessages.exampleErrorAuthFlowWrongUser);
    }

    return User(
        name: Constants.exampleAuthFlowTestUserName,
        email: Constants.exampleAuthFlowTestEmail);
  }

  @override
  Future<void> signOut() {
    return null;
  }
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException(
      {this.message = ErrorMessages.exampleErrorAuthFlowUnknown});
}
