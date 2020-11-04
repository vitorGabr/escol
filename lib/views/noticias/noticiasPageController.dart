import 'dart:async';

import 'package:escol/modules/firebase/repositories/firebaseFirestoreRepository.dart';
import 'package:escol/modules/noticias/models/enum/categoriaEnum.dart';
import 'package:escol/modules/noticias/models/noticiaModel.dart';
import 'package:mobx/mobx.dart';
part 'noticiasPageController.g.dart';

class NoticiasPageController = _NoticiasPageControllerBase with _$NoticiasPageController;

abstract class _NoticiasPageControllerBase with Store {

  _NoticiasPageControllerBase(String _uid){
    getNoticias(_uid);
  }

  final FirebaseFirestoreRepository _firestoreRepository = FirebaseFirestoreRepository();

  @observable
  int _categoria = CategoriaEnum.importante.index;

  int get categoria => _categoria;

  @observable
  ObservableFuture<List<NoticiaModel>> listNoticias;

  @action
  int setCategoria(int _newCategoria) => _categoria = _newCategoria;

  void getNoticias(String _uid){
    listNoticias = _firestoreRepository.getNoticias(_uid).asObservable();
  }
 
  List<NoticiaModel> filteredNoticias(int _categoria) {
    List<NoticiaModel> _list = [];
    listNoticias.value.forEach((_noticia) { 
      var _categoriaFiltered = _noticia.categorias.indexOf(_categoria);
      if(_categoriaFiltered != -1){
        _list.add(_noticia);
      }
    });
    return _list;
  }

}