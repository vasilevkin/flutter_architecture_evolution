import 'package:mobx/mobx.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/app/error_messages.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_signup_form/custom_color.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_signup_form/form_error_state.dart';
import 'package:validators/validators.dart';

part 'form_store.g.dart';

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  final FormErrorState error = FormErrorState();

  @observable
  CustomColor color;

  @observable
  String name = '';

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  ObservableFuture<bool> usernameCheck = ObservableFuture.value(true);

  @computed
  bool get isUserCheckPending => usernameCheck.status == FutureStatus.pending;

  @computed
  bool get canLogin => !error.hasErrors;

  List<ReactionDisposer> _disposers;

  void setupValidations() {
    _disposers = [
      reaction((_) => name, validateUserName),
      reaction((_) => email, validateEmail),
      reaction((_) => password, validatePassword),
    ];
  }

  @action
  Future validateUserName(String value) async {
    if (isNull(value) || value.isEmpty) {
      error.username = ErrorMessages.exampleFormBlank;
      return;
    }

    try {
      usernameCheck = ObservableFuture(checkValidUsername(value));

      error.username = null;
      final isValid = await usernameCheck;

      if (!isValid) {
        error.username = ErrorMessages.exampleFormUsernameAdmin;
        return;
      }
    } on Object catch (_) {
      error.username = null;
    }

    error.username = null;
  }

  @action
  void validateEmail(String value) {
    error.email = isEmail(value) ? null : ErrorMessages.exampleFormEmail;
  }

  @action
  void validatePassword(String value) {
    error.password =
        isNull(value) || value.isEmpty ? ErrorMessages.exampleFormBlank : null;
  }

  Future<bool> checkValidUsername(String value) async {
    await Future.delayed(const Duration(seconds: 1));
    return value != Constants.exampleFormAdmin;
  }

  void validateAll() {
    validatePassword(password);
    validateEmail(email);
    validateUserName(name);
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
