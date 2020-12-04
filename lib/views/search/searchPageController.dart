import 'package:escol/modules/firebase/models/firebaseUserModel.dart';
import 'package:escol/modules/firebase/repositories/firebaseFirestoreRepository.dart';
import 'package:escol/modules/shared/repositories/sharePreferencesRepository.dart';
import 'package:mobx/mobx.dart';
part 'searchPageController.g.dart';

class SearchPageController = _SearchPageControllerBase
    with _$SearchPageController;

abstract class _SearchPageControllerBase with Store {
  final FirebaseFirestoreRepository _firestoreRepository =
      FirebaseFirestoreRepository();

  final SharePreferencesRepository _sharedPreference =
      SharePreferencesRepository();

  @observable
  String _search = '';

  String get search => _search;

  @action
  String setSearch(String _text) => _search = _text;

  @observable
  ObservableFuture<List<FirebaseUserModel>> users;

  void searchUsers(String _uid, String _params) {
    users = _firestoreRepository.searchUsers(_uid, _params).asObservable();
  }

  Future<void> saveSearchHistory() async {}
}
