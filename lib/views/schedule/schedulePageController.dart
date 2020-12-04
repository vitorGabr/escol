import 'dart:async';

import 'package:escol/modules/student/models/scheduleModel.dart';
import 'package:escol/modules/student/models/subjectModel.dart';
import 'package:escol/modules/firebase/repositories/firebaseFirestoreRepository.dart';
import 'package:mobx/mobx.dart';
part 'schedulePageController.g.dart';

class SchedulePageController = _SchedulePageControllerBase
    with _$SchedulePageController;

abstract class _SchedulePageControllerBase with Store {
  final FirebaseFirestoreRepository _firestoreRepository =
      FirebaseFirestoreRepository();

  _SchedulePageControllerBase(String _uid) {
    getHorario(_uid);
    getMateria(_uid);
  }

  @observable
  ObservableFuture<List<ScheduleModel>> listHorario;

  @observable
  ObservableFuture<List<SubjectModel>> listMaterias;

  @observable
  int _daySelected = 0;

  int get daySelected => _daySelected;

  void getHorario(String _uid) {
    listHorario = _firestoreRepository.getSchedule(_uid).asObservable();
  }

  void getMateria(String _uid) {
    listMaterias = _firestoreRepository.getSubjects(_uid).asObservable();
  }

  @action
  void changeDaySelected(int day) => _daySelected = day;

  @action
  void setListHorarios(List<ScheduleModel> _horarios) {
    var _completer = Completer<List<ScheduleModel>>();
    listHorario = _completer.future.asObservable();
    _completer.complete(_horarios);
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
}
