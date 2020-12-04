// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homePageController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomePageController on _HomePageControllerBase, Store {
  final _$subjectListsAtom = Atom(name: '_HomePageControllerBase.subjectLists');

  @override
  ObservableFuture<List<SubjectModel>> get subjectLists {
    _$subjectListsAtom.reportRead();
    return super.subjectLists;
  }

  @override
  set subjectLists(ObservableFuture<List<SubjectModel>> value) {
    _$subjectListsAtom.reportWrite(value, super.subjectLists, () {
      super.subjectLists = value;
    });
  }

  final _$newsAtom = Atom(name: '_HomePageControllerBase.news');

  @override
  ObservableFuture<NewsModel> get news {
    _$newsAtom.reportRead();
    return super.news;
  }

  @override
  set news(ObservableFuture<NewsModel> value) {
    _$newsAtom.reportWrite(value, super.news, () {
      super.news = value;
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

  final _$classListsAtom = Atom(name: '_HomePageControllerBase.classLists');

  @override
  ObservableFuture<List<ClassModel>> get classLists {
    _$classListsAtom.reportRead();
    return super.classLists;
  }

  @override
  set classLists(ObservableFuture<List<ClassModel>> value) {
    _$classListsAtom.reportWrite(value, super.classLists, () {
      super.classLists = value;
    });
  }

  @override
  String toString() {
    return '''
subjectLists: ${subjectLists},
news: ${news},
facebookPost: ${facebookPost},
classLists: ${classLists}
    ''';
  }
}
