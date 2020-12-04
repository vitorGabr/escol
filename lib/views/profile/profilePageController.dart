import 'package:escol/modules/student/models/schoolModel.dart';
import 'package:escol/modules/firebase/repositories/firebaseFirestoreRepository.dart';
import 'package:mobx/mobx.dart';
part 'profilePageController.g.dart';

class ProfilePageController = _ProfilePageControllerBase
    with _$ProfilePageController;

abstract class _ProfilePageControllerBase with Store {
  _ProfilePageControllerBase(String _uid) {
    getSchoolnfo(_uid);
  }

  final FirebaseFirestoreRepository _firestoreRepository =
      FirebaseFirestoreRepository();

  @observable
  ObservableFuture<SchoolModel> school;

  void getSchoolnfo(String _uid) {
    school = _firestoreRepository.getSchoolInfo(_uid).asObservable();
  }
}
