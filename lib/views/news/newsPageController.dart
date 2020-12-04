import 'package:escol/modules/firebase/repositories/firebaseFirestoreRepository.dart';
import 'package:escol/modules/news/models/enum/categoriaEnum.dart';
import 'package:escol/modules/news/models/newsModel.dart';
import 'package:mobx/mobx.dart';
part 'newsPageController.g.dart';

class NewsPageController = _NewsPageControllerBase with _$NewsPageController;

abstract class _NewsPageControllerBase with Store {
  _NewsPageControllerBase(String _uid) {
    getNews(_uid);
  }

  final FirebaseFirestoreRepository _firestoreRepository =
      FirebaseFirestoreRepository();

  @observable
  int _category = CategoriaEnum.important.index;

  int get category => _category;

  @observable
  ObservableFuture<List<NewsModel>> newsList;

  @action
  int setCategory(int _newCategory) => _category = _newCategory;

  void getNews(String _uid) {
    newsList = _firestoreRepository.getNews(_uid).asObservable();
  }

  List<NewsModel> filteredNews(int _category) {
    List<NewsModel> _list = [];
    newsList.value.forEach((_news) {
      var _categoryFiltered = _news.category.indexOf(_category);
      if (_categoryFiltered != -1) {
        _list.add(_news);
      }
    });
    return _list;
  }
}
