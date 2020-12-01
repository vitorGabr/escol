import 'dart:async';

import 'package:escol/modules/aluno/models/aulaModel.dart';
import 'package:escol/modules/aluno/models/horarioModel.dart';
import 'package:escol/modules/aluno/models/materiaModel.dart';
import 'package:escol/modules/firebase/repositories/firebaseFirestoreRepository.dart';
import 'package:escol/modules/shared/models/responseDefaultModel.dart';
import 'package:mobx/mobx.dart';
part 'horarioEditModalController.g.dart';

class HorarioEditModalController = _HorarioEditModalControllerBase
    with _$HorarioEditModalController;

abstract class _HorarioEditModalControllerBase with Store {
  final FirebaseFirestoreRepository _firestoreRepository =
      FirebaseFirestoreRepository();

  @observable
  int _daySelected = 0;

  @observable
  String _dropDownValue = '';

  @observable
  ObservableList<HorarioModel> listHorarios = ObservableList<HorarioModel>();

  @observable
  ObservableFuture<ResponseDefaultModel> isLoaded;

  @observable
  ObservableList<MateriaModel> listMaterias = ObservableList<MateriaModel>();

  String get dropDownValue => _dropDownValue;
  int get daySelected => _daySelected;

  @action
  changeDaySelected(int day) => _daySelected = day;
  @action
  changeDropDownValue(String _newValue) => _dropDownValue = _newValue;
  @action
  setListMaterias(List<MateriaModel> _newList) => listMaterias.addAll(_newList);
  @action
  setListHorarios(List<HorarioModel> _newList) {
    var _listToMap = {for (var v in _newList) _newList.indexOf(v): v};
    List<HorarioModel> _horarios = List<HorarioModel>();
    _listToMap.forEach((key, value) {
      List<AulaModel> _listAulas = [];
      value.aulas.forEach((element) {
        var _json = AulaModel.fromJson(element.toJson());
        _listAulas.add(_json);
      });
      _horarios.add(HorarioModel()
        ..aulas = _listAulas
        ..diaDaSemana = key);
    });
    listHorarios.addAll(_horarios);
  }

  MateriaModel getMateriaCompleta(AulaModel _aula) {
    return listMaterias
        .where((materia) => materia.nomeAbreviado == _aula.materia)
        .first;
  }

  @action
  changeHorario(String _value, int idx) {
    MateriaModel _materia =
        listMaterias.where((_materia) => _materia.nome == _value).first;
    List<HorarioModel> _list = listHorarios;
    _list[daySelected].aulas[idx]
      ..isExpanded = !_list[daySelected].aulas[idx].isExpanded
      ..materia = _materia.nomeAbreviado
      ..professor = _materia.professor;

    listHorarios = _list;
  }

  DateTime getMonday(int day) {
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

    if (!(day == 0)) {
      _dateFormat = _dateFormat.add(Duration(days: day));
    }

    return _dateFormat;
  }

  Future<ResponseDefaultModel> saveHorario(
      String _uid, List<HorarioModel> _list) async {
    var _completer = Completer<ResponseDefaultModel>();
    isLoaded = _completer.future.asObservable();
    var _result = await _firestoreRepository.saveHorario(_uid, _list);
    if (_result.isSuccess) {
      _completer.complete(_result);
    }
    return _result;
  }
}
