// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configurationPageController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConfigurationPageController on _ConfigurationPageControllerBase, Store {
  final _$didLogoutAtom =
      Atom(name: '_ConfigurationPageControllerBase.didLogout');

  @override
  ObservableFuture<ResponseDefaultModel<dynamic>> get didLogout {
    _$didLogoutAtom.reportRead();
    return super.didLogout;
  }

  @override
  set didLogout(ObservableFuture<ResponseDefaultModel<dynamic>> value) {
    _$didLogoutAtom.reportWrite(value, super.didLogout, () {
      super.didLogout = value;
    });
  }

  final _$logoutAsyncAction =
      AsyncAction('_ConfigurationPageControllerBase.logout');

  @override
  Future<bool> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''
didLogout: ${didLogout}
    ''';
  }
}
