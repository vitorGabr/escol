// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'noticiasPageController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NoticiasPageController on _NoticiasPageControllerBase, Store {
  final _$_categoriaAtom = Atom(name: '_NoticiasPageControllerBase._categoria');

  @override
  int get _categoria {
    _$_categoriaAtom.reportRead();
    return super._categoria;
  }

  @override
  set _categoria(int value) {
    _$_categoriaAtom.reportWrite(value, super._categoria, () {
      super._categoria = value;
    });
  }

  final _$listNoticiasAtom =
      Atom(name: '_NoticiasPageControllerBase.listNoticias');

  @override
  ObservableFuture<List<NoticiaModel>> get listNoticias {
    _$listNoticiasAtom.reportRead();
    return super.listNoticias;
  }

  @override
  set listNoticias(ObservableFuture<List<NoticiaModel>> value) {
    _$listNoticiasAtom.reportWrite(value, super.listNoticias, () {
      super.listNoticias = value;
    });
  }

  final _$_NoticiasPageControllerBaseActionController =
      ActionController(name: '_NoticiasPageControllerBase');

  @override
  int setCategoria(int _newCategoria) {
    final _$actionInfo = _$_NoticiasPageControllerBaseActionController
        .startAction(name: '_NoticiasPageControllerBase.setCategoria');
    try {
      return super.setCategoria(_newCategoria);
    } finally {
      _$_NoticiasPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listNoticias: ${listNoticias}
    ''';
  }
}
