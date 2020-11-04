// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perfilPageController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PerfilPageController on _PerfilPageControllerBase, Store {
  final _$escolaAtom = Atom(name: '_PerfilPageControllerBase.escola');

  @override
  ObservableFuture<EscolaModel> get escola {
    _$escolaAtom.reportRead();
    return super.escola;
  }

  @override
  set escola(ObservableFuture<EscolaModel> value) {
    _$escolaAtom.reportWrite(value, super.escola, () {
      super.escola = value;
    });
  }

  @override
  String toString() {
    return '''
escola: ${escola}
    ''';
  }
}
