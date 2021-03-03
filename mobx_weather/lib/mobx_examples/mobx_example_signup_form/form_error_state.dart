import 'package:mobx/mobx.dart';

part 'form_error_state.g.dart';

class FormErrorState = _FormErrorState with _$FormErrorState;

abstract class _FormErrorState with Store {
  @observable
  String username;

  @observable
  String email;

  @observable
  String password;

  @computed
  bool get hasErrors => username != null || email != null || password != null;
}
