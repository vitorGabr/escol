import 'dart:async';

import 'package:escol/modules/student/models/eventModel/eventDayModel.dart';
import 'package:escol/modules/student/models/eventModel/eventosMonthModel.dart';
import 'package:escol/modules/firebase/repositories/firebaseFirestoreRepository.dart';
import 'package:mobx/mobx.dart';
part 'calendarPageController.g.dart';

class CalendarPageController = _CalendarPageControllerBase
    with _$CalendarPageController;

abstract class _CalendarPageControllerBase with Store {
  _CalendarPageControllerBase(String _uid) {
    getEventList(_uid);
  }

  final FirebaseFirestoreRepository _firestoreRepository =
      FirebaseFirestoreRepository();

  @observable
  ObservableFuture<List<EventMonthModel>> eventList;

  @observable
  Map<DateTime, List<dynamic>> selectedEvents = {};

  @action
  void transformInEvents() {
    eventList.value.forEach((_result) {
      _result.events.forEach((_value) {
        selectedEvents[_value.day] = _value.events;
      });
    });
  }

  void getEventList(String _uid) {
    eventList = _firestoreRepository.getEventList(_uid).asObservable();
  }

  void filterEvents(DateTime _newDate, List _neweventList) {
    var _completer = Completer<List<EventMonthModel>>();
    var filteredEventsDia = EventDayModel()
      ..day = _newDate
      ..events = _neweventList.isEmpty ? [] : _neweventList;
    var filteredEventsMes = EventMonthModel()
      ..month = _newDate
      ..events = [filteredEventsDia];
    eventList = _completer.future.asObservable();
    _completer.complete([filteredEventsMes]);
  }

  String formatTime(DateTime _date) {
    String _dateFormated = '${_date.hour}:${_date.minute}';
    if (_date.minute < 10) {
      _dateFormated = '${_date.hour}:0${_date.minute}';
    }
    return _dateFormated;
  }
}
