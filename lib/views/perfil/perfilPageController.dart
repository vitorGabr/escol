import 'package:escol/modules/aluno/models/escolaModel.dart';
import 'package:escol/modules/firebase/repositories/firebaseFirestoreRepository.dart';
import 'package:mobx/mobx.dart';
part 'perfilPageController.g.dart';

class PerfilPageController = _PerfilPageControllerBase with _$PerfilPageController;

abstract class _PerfilPageControllerBase with Store {
  
  _PerfilPageControllerBase(String _uid){
    getInfoSala(_uid);
  }

  final FirebaseFirestoreRepository _firestoreRepository = FirebaseFirestoreRepository();

  @observable
  ObservableFuture<EscolaModel> escola;

  void getInfoSala(String _uid){
    escola = _firestoreRepository.getInfoEscola(_uid).asObservable();
  }

}
