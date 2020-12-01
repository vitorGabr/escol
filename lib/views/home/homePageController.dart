import 'package:escol/modules/aluno/models/aulaModel.dart';
import 'package:escol/modules/aluno/models/materiaModel.dart';
import 'package:escol/modules/firebase/repositories/firebaseFirestoreRepository.dart';
import 'package:escol/modules/noticias/models/noticiaModel.dart';
import 'package:escol/modules/shared/models/facebookModel.dart';
import 'package:escol/modules/shared/models/responseDefaultModel.dart';
import 'package:escol/modules/shared/repositories/facebookRepository.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
part 'homePageController.g.dart';

class HomePageController = _HomePageControllerBase with _$HomePageController;

abstract class _HomePageControllerBase with Store {
  final FacebookRepository _facebookRepository = FacebookRepository();
  final FirebaseFirestoreRepository _firestoreRepository =
      FirebaseFirestoreRepository();

  _HomePageControllerBase(String _uid) {
    getMaterias(_uid);
    getAulas(_uid);
    getNoticias(_uid);
  }

  @observable
  ObservableFuture<List<MateriaModel>> listMaterias;

  @observable
  ObservableFuture<NoticiaModel> noticia;

  @observable
  ObservableFuture<ResponseDefaultModel<FacebookModel>> facebookPost;

  @observable
  ObservableFuture<List<AulaModel>> listAulas;

  void getMaterias(String _uid) {
    listMaterias = _firestoreRepository.getMaterias(_uid).asObservable();
  }

  void getAulas(String _uid) {
    listAulas = _firestoreRepository.getAulas(_uid).asObservable();
  }

  void getFacebookPost() {
    facebookPost = _facebookRepository
        .getPostsAsync('id,posts{full_picture,message}',
            'EAAh4tx08TzABADU6extCq1sDMgtMMTH8FmUjRwx1XlrCMh9qYdQIRcdf8sqTBKfpIDgp9UqPcXrTD9yHVpJ2UXJQvDrV5jP3TAwT4btVeZCNYM3MN8IEUlYu1GGJjYu83adoP7yuoiqW0PvVvYGo0B1mPE5bUZBoZAacuSigOoPRxCZC0pDh')
        .asObservable();
  }

  void getNoticias(String _uid) {
    noticia = _firestoreRepository.getLastNoticia(_uid).asObservable();
  }

  String getDate() {
    var _date = DateTime.now();
    final _dayFormat = DateFormat('EEEE', 'pt_BR');
    if (_date.weekday > 5 || _date.weekday == 0) {
      if (_date.weekday == 6) {
        _date = _date.subtract(Duration(days: 5));
      }
      _date = _date.subtract(Duration(days: 4));
    }
    return _dayFormat.format(_date);
  }

  String getDateFormated() {
    var _date = DateTime.now();
    final _dayFormat = DateFormat('d, MMMM', 'pt_BR');

    return _dayFormat.format(_date);
  }

  String nameFormated(String _name) {
    var _nameIndex = _name.indexOf(' ');

    return _name.substring(0, _nameIndex);
  }
}
