// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PesquisaPageController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PesquisaPageController on _PesquisaPageControllerBase, Store {
  final _$_searchAtom = Atom(name: '_PesquisaPageControllerBase._search');

  @override
  String get _search {
    _$_searchAtom.reportRead();
    return super._search;
  }

  @override
  set _search(String value) {
    _$_searchAtom.reportWrite(value, super._search, () {
      super._search = value;
    });
  }

  final _$usersAtom = Atom(name: '_PesquisaPageControllerBase.users');

  @override
  ObservableFuture<List<FirebaseUserModel>> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(ObservableFuture<List<FirebaseUserModel>> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  final _$_PesquisaPageControllerBaseActionController =
      ActionController(name: '_PesquisaPageControllerBase');

  @override
  String setSearch(String _text) {
    final _$actionInfo = _$_PesquisaPageControllerBaseActionController
        .startAction(name: '_PesquisaPageControllerBase.setSearch');
    try {
      return super.setSearch(_text);
    } finally {
      _$_PesquisaPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
users: ${users}
    ''';
  }
}
