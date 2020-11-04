// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homePageController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomePageController on _HomePageControllerBase, Store {
  final _$listMateriasAtom = Atom(name: '_HomePageControllerBase.listMaterias');

  @override
  ObservableFuture<List<MateriaModel>> get listMaterias {
    _$listMateriasAtom.reportRead();
    return super.listMaterias;
  }

  @override
  set listMaterias(ObservableFuture<List<MateriaModel>> value) {
    _$listMateriasAtom.reportWrite(value, super.listMaterias, () {
      super.listMaterias = value;
    });
  }

  final _$noticiaAtom = Atom(name: '_HomePageControllerBase.noticia');

  @override
  ObservableFuture<NoticiaModel> get noticia {
    _$noticiaAtom.reportRead();
    return super.noticia;
  }

  @override
  set noticia(ObservableFuture<NoticiaModel> value) {
    _$noticiaAtom.reportWrite(value, super.noticia, () {
      super.noticia = value;
    });
  }

  final _$facebookPostAtom = Atom(name: '_HomePageControllerBase.facebookPost');

  @override
  ObservableFuture<ResponseDefaultModel<FacebookModel>> get facebookPost {
    _$facebookPostAtom.reportRead();
    return super.facebookPost;
  }

  @override
  set facebookPost(
      ObservableFuture<ResponseDefaultModel<FacebookModel>> value) {
    _$facebookPostAtom.reportWrite(value, super.facebookPost, () {
      super.facebookPost = value;
    });
  }

  final _$listAulasAtom = Atom(name: '_HomePageControllerBase.listAulas');

  @override
  ObservableFuture<List<AulaModel>> get listAulas {
    _$listAulasAtom.reportRead();
    return super.listAulas;
  }

  @override
  set listAulas(ObservableFuture<List<AulaModel>> value) {
    _$listAulasAtom.reportWrite(value, super.listAulas, () {
      super.listAulas = value;
    });
  }

  @override
  String toString() {
    return '''
listMaterias: ${listMaterias},
noticia: ${noticia},
facebookPost: ${facebookPost},
listAulas: ${listAulas}
    ''';
  }
}
