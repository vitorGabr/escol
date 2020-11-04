// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'studentPageContoller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StudentPageController on _StudentPageControllerBase, Store {
  final _$loginAtom = Atom(name: '_StudentPageControllerBase.login');

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

  final _$_isVisibilityAtom =
      Atom(name: '_StudentPageControllerBase._isVisibility');

  @override
  bool get _isVisibility {
    _$_isVisibilityAtom.reportRead();
    return super._isVisibility;
  }

  @override
  set _isVisibility(bool value) {
    _$_isVisibilityAtom.reportWrite(value, super._isVisibility, () {
      super._isVisibility = value;
    });
  }

  final _$signInWithEmailAndPasswordAsyncAction =
      AsyncAction('_StudentPageControllerBase.signInWithEmailAndPassword');

  @override
  Future<ResponseDefaultModel<dynamic>> signInWithEmailAndPassword(
      String email, String password) {
    return _$signInWithEmailAndPasswordAsyncAction
        .run(() => super.signInWithEmailAndPassword(email, password));
  }

  final _$_StudentPageControllerBaseActionController =
      ActionController(name: '_StudentPageControllerBase');

  @override
  void setVisibility(bool _value) {
    final _$actionInfo = _$_StudentPageControllerBaseActionController
        .startAction(name: '_StudentPageControllerBase.setVisibility');
    try {
      return super.setVisibility(_value);
    } finally {
      _$_StudentPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
login: ${login}
    ''';
  }
}
