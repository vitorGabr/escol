import 'dart:async';

import 'package:escol/modules/aluno/models/horarioModel.dart';
import 'package:escol/modules/aluno/models/materiaModel.dart';
import 'package:escol/modules/firebase/repositories/firebaseFirestoreRepository.dart';
import 'package:mobx/mobx.dart';
part 'horarioPageController.g.dart';

class HorarioPageController = _HorarioPageControllerBase with _$HorarioPageController;

abstract class _HorarioPageControllerBase with Store {
  
  final FirebaseFirestoreRepository _firestoreRepository = FirebaseFirestoreRepository();

  _HorarioPageControllerBase(String _uid){
    getHorario(_uid);
    getMateria(_uid);
  }

  @observable
  ObservableFuture<List<HorarioModel>> listHorario;

  @observable
  ObservableFuture<List<MateriaModel>> listMaterias;

  @observable
  int _daySelected = 0;

  int get daySelected => _daySelected;

  void getHorario(String _uid){
    listHorario = _firestoreRepository.getHorario(_uid).asObservable();
  }

  void getMateria(String _uid){
    listMaterias = _firestoreRepository.getMaterias(_uid).asObservable();
  }

  @action
  void changeDaySelected(int day) => _daySelected = day;

  @action
  void setListHorarios(List<HorarioModel> _horarios){
    var _completer = Completer<List<HorarioModel>>();
    listHorario = _completer.future.asObservable();
    _completer.complete(_horarios);
  }

  DateTime getMonday(int day){
    var _date = DateTime.now();
    DateTime _dateFormat;

    switch (_date.weekday) {
      case 1:
        _dateFormat = _date;
        break;
      case 2:
        _dateFormat = _date.subtract(Duration(days: 1));
        break;
      case 3:
        _dateFormat = _date.subtract(Duration(days: 2));
        break;
      case 4:
        _dateFormat = _date.subtract(Duration(days: 3));
        break;
      case 5:
        _dateFormat = _date.subtract(Duration(days: 4));
        break;
      case 6:
        _dateFormat = _date.subtract(Duration(days: 5));
        break;
      default:
        _dateFormat = _date.subtract(Duration(days: 6));
    }

    if(!(day == 0)){
      _dateFormat = _dateFormat.add(Duration(days: day));
    }

    return _dateFormat;
  }

  

}