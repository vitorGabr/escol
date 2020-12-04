import 'dart:async';

import 'package:escol/modules/student/models/classModel.dart';
import 'package:escol/modules/student/models/scheduleModel.dart';
import 'package:escol/modules/student/models/subjectModel.dart';
import 'package:escol/modules/firebase/repositories/firebaseFirestoreRepository.dart';
import 'package:escol/modules/shared/models/responseDefaultModel.dart';
import 'package:mobx/mobx.dart';
part 'scheduleEditModalController.g.dart';

class ScheduleEditModalController = _ScheduleEditModalControllerBase
    with _$ScheduleEditModalController;

abstract class _ScheduleEditModalControllerBase with Store {
  final FirebaseFirestoreRepository _firestoreRepository =
      FirebaseFirestoreRepository();

  @observable
  int _daySelected = 0;

  @observable
  String _dropDownValue = '';

  @observable
  ObservableList<ScheduleModel> listHorarios = ObservableList<ScheduleModel>();

  @observable
  ObservableFuture<ResponseDefaultModel> isLoaded;

  @observable
  ObservableList<SubjectModel> listMaterias = ObservableList<SubjectModel>();

  String get dropDownValue => _dropDownValue;
  int get daySelected => _daySelected;

  @action
  changeDaySelected(int day) => _daySelected = day;
  @action
  changeDropDownValue(String _newValue) => _dropDownValue = _newValue;
  @action
  setListMaterias(List<SubjectModel> _newList) => listMaterias.addAll(_newList);
  @action
  setListHorarios(List<ScheduleModel> _newList) {
    var _listToMap = {for (var v in _newList) _newList.indexOf(v): v};
    List<ScheduleModel> _horarios = List<ScheduleModel>();
    _listToMap.forEach((key, value) {
      List<ClassModel> _listAulas = [];
      value.classes.forEach((element) {
        var _json = ClassModel.fromJson(element.toJson());
        _listAulas.add(_json);
      });
      _horarios.add(ScheduleModel()
        ..classes = _listAulas
        ..weekDay = key);
    });
    listHorarios.addAll(_horarios);
  }

  SubjectModel getMateriaCompleta(ClassModel _aula) {
    return listMaterias
        .where((materia) => materia.shortName == _aula.subject)
        .first;
  }

  @action
  changeHorario(String _value, int idx) {
    SubjectModel _materia =
        listMaterias.where((_materia) => _materia.name == _value).first;
    List<ScheduleModel> _list = listHorarios;
    _list[daySelected].classes[idx]
      ..isExpanded = !_list[daySelected].classes[idx].isExpanded
      ..subject = _materia.shortName
      ..teacher = _materia.teacher;

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
      String _uid, List<ScheduleModel> _list) async {
    var _completer = Completer<ResponseDefaultModel>();
    isLoaded = _completer.future.asObservable();
    var _result = await _firestoreRepository.saveSchedule(_uid, _list);
    if (_result.isSuccess) {
      _completer.complete(_result);
    }
    return _result;
  }
}
