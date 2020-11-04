// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mainLoginPageController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainLoginPageController on _MainLoginPageControllerBase, Store {
  final _$loginAtom = Atom(name: '_MainLoginPageControllerBase.login');

  @override
  ObservableFuture<ResponseDefaultModel<User>> get login {
    _$loginAtom.reportRead();
    return super.login;
  }

  @override
  set login(ObservableFuture<ResponseDefaultModel<User>> value) {
    _$loginAtom.reportWrite(value, super.login, () {
      super.login = value;
    });
  }

  @override
  String toString() {
    return '''
login: ${login}
    ''';
  }
}
