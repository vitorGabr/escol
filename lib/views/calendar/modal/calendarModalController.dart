import 'dart:async';

import 'package:escol/modules/firebase/repositories/firebaseFirestoreRepository.dart';
import 'package:escol/modules/shared/models/responseDefaultModel.dart';
import 'package:escol/modules/student/models/classroomModel.dart';
import 'package:escol/modules/student/models/eventModel/eventModel.dart';
import 'package:escol/modules/student/models/subjectModel.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'calendarModalController.g.dart';

class CalendarModalController = _CalendarModalControllerBase
    with _$CalendarModalController;

abstract class _CalendarModalControllerBase with Store {
  _CalendarModalControllerBase(String _uid) {
    getInfoSala(_uid);
    getMaterias(_uid);
  }

  final FirebaseFirestoreRepository _firestoreRepository =
      FirebaseFirestoreRepository();

  @observable
  ObservableFuture<ClassroomModel> sala;

  @observable
  ObservableFuture<List<SubjectModel>> materias;

  @observable
  ObservableList<String> aulas = <String>[].asObservable();

  @observable
  ObservableFuture<ResponseDefaultModel> isLoaded;

  @observable
  DateTime _selectedDate;

  @observable
  TimeOfDay _selectedTime;

  @observable
  String _dropdown = '';

  DateTime get selectedDate => _selectedDate;
  TimeOfDay get selectedTime => _selectedTime;
  String get dropdown => _dropdown;

  @action
  changePicked(DateTime _date) => _selectedDate = _date;

  @action
  changeTimePicked(TimeOfDay _time) => _selectedTime = _time;

  @action
  changeDropdown(String _newValue) => _dropdown = _newValue;

  @action
  Future<void> getInfoSala(String _uid) async {
    var _completer = Completer<ClassroomModel>();
    sala = _completer.future.asObservable();
    var _result = await _firestoreRepository.getClassInfo(_uid).asObservable();
    if (_result != null) {
      for (var _aula = 1; _aula <= _result.classesNumber; _aula++) {
        aulas.add('$_aula\º Aula');
      }
    }
    _completer.complete(_result);
  }

  Future<void> getMaterias(String _uid) async {
    var _completer = Completer<List<SubjectModel>>();
    materias = _completer.future.asObservable();
    var _result = await _firestoreRepository.getSubjects(_uid).asObservable();
    _dropdown = _result.first.name;
    _completer.complete(_result);
  }

  bool isValidated(String _titulo, String _descricao) {
    if (_titulo != null &&
        _titulo.length > 0 &&
        _descricao != null &&
        _descricao.length > 0) {
      if (_selectedDate != null && _selectedTime != null) {
        return true;
      }
    }
    return false;
  }

  Future<ResponseDefaultModel> saveEvento(
      String _uid, EventModel _evento) async {
    var _completer = Completer<ResponseDefaultModel>();
    isLoaded = _completer.future.asObservable();
    var _result = await _firestoreRepository.saveEvent(_uid, _evento);
    if (_result.isSuccess) {
      _completer.complete(_result);
    }
    return _result;
  }
}
