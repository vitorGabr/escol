// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newsPageController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewsPageController on _NewsPageControllerBase, Store {
  final _$_categoryAtom = Atom(name: '_NewsPageControllerBase._category');

  @override
  int get _category {
    _$_categoryAtom.reportRead();
    return super._category;
  }

  @override
  set _category(int value) {
    _$_categoryAtom.reportWrite(value, super._category, () {
      super._category = value;
    });
  }

  final _$newsListAtom = Atom(name: '_NewsPageControllerBase.newsList');

  @override
  ObservableFuture<List<NewsModel>> get newsList {
    _$newsListAtom.reportRead();
    return super.newsList;
  }

  @override
  set newsList(ObservableFuture<List<NewsModel>> value) {
    _$newsListAtom.reportWrite(value, super.newsList, () {
      super.newsList = value;
    });
  }

  final _$_NewsPageControllerBaseActionController =
      ActionController(name: '_NewsPageControllerBase');

  @override
  int setCategory(int _newCategory) {
    final _$actionInfo = _$_NewsPageControllerBaseActionController.startAction(
        name: '_NewsPageControllerBase.setCategory');
    try {
      return super.setCategory(_newCategory);
    } finally {
      _$_NewsPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
newsList: ${newsList}
    ''';
  }
}
