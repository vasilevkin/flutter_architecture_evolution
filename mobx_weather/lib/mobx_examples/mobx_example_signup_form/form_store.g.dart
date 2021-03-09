// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FormStore on _FormStore, Store {
  Computed<bool> _$isUserCheckPendingComputed;

  @override
  bool get isUserCheckPending => (_$isUserCheckPendingComputed ??=
          Computed<bool>(() => super.isUserCheckPending,
              name: '_FormStore.isUserCheckPending'))
      .value;
  Computed<bool> _$canLoginComputed;

  @override
  bool get canLogin => (_$canLoginComputed ??=
          Computed<bool>(() => super.canLogin, name: '_FormStore.canLogin'))
      .value;

  final _$colorAtom = Atom(name: '_FormStore.color');

  @override
  CustomColor get color {
    _$colorAtom.reportRead();
    return super.color;
  }

  @override
  set color(CustomColor value) {
    _$colorAtom.reportWrite(value, super.color, () {
      super.color = value;
    });
  }

  final _$nameAtom = Atom(name: '_FormStore.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$emailAtom = Atom(name: '_FormStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_FormStore.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$confirmPasswordAtom = Atom(name: '_FormStore.confirmPassword');

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  final _$usernameCheckAtom = Atom(name: '_FormStore.usernameCheck');

  @override
  ObservableFuture<bool> get usernameCheck {
    _$usernameCheckAtom.reportRead();
    return super.usernameCheck;
  }

  @override
  set usernameCheck(ObservableFuture<bool> value) {
    _$usernameCheckAtom.reportWrite(value, super.usernameCheck, () {
      super.usernameCheck = value;
    });
  }

  final _$validateUserNameAsyncAction =
      AsyncAction('_FormStore.validateUserName');

  @override
  Future<dynamic> validateUserName(String value) {
    return _$validateUserNameAsyncAction
        .run(() => super.validateUserName(value));
  }

  final _$_FormStoreActionController = ActionController(name: '_FormStore');

  @override
  void validateEmail(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateEmail');
    try {
      return super.validateEmail(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validatePassword');
    try {
      return super.validatePassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateConfirmPassword(String confirm) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateConfirmPassword');
    try {
      return super.validateConfirmPassword(confirm);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
color: ${color},
name: ${name},
email: ${email},
password: ${password},
confirmPassword: ${confirmPassword},
usernameCheck: ${usernameCheck},
isUserCheckPending: ${isUserCheckPending},
canLogin: ${canLogin}
    ''';
  }
}
