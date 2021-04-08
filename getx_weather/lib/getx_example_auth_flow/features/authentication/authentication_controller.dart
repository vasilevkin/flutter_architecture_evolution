import 'package:get/get.dart';
import 'package:getx_weather/getx_example_auth_flow/features/authentication/authentication_service.dart';
import 'package:getx_weather/getx_example_auth_flow/features/authentication/authentication_state.dart';

class AuthenticationController extends GetxController {
  final AuthenticationService _authenticationService;
  final _authStateStream = AuthenticationState().obs;

  AuthenticationState get state => _authStateStream.value;

  AuthenticationController(this._authenticationService);

  @override
  void onInit() {
    _getAuthenticatedUser();
    super.onInit();
  }

  Future<void> signIn(String email, String password) async {
    final user = await _authenticationService.signInWithEmailAndPassword(
        email, password);
    _authStateStream.value = Authenticated(user: user);
  }

  void signOut() async {
    await _authenticationService.signOut();
    _authStateStream.value = UnAuthenticated();
  }

  void _getAuthenticatedUser() async {
    _authStateStream.value = AuthenticationLoading();

    final user = await _authenticationService.getCurrentUser();

    if (user == null) {
      _authStateStream.value = UnAuthenticated();
    } else {
      _authStateStream.value = Authenticated(user: user);
    }
  }
}
