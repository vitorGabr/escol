// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedulePageController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SchedulePageController on _SchedulePageControllerBase, Store {
  final _$listHorarioAtom =
      Atom(name: '_SchedulePageControllerBase.listHorario');

  @override
  ObservableFuture<List<ScheduleModel>> get listHorario {
    _$listHorarioAtom.reportRead();
    return super.listHorario;
  }

  @override
  set listHorario(ObservableFuture<List<ScheduleModel>> value) {
    _$listHorarioAtom.reportWrite(value, super.listHorario, () {
      super.listHorario = value;
    });
  }

  final _$listMateriasAtom =
      Atom(name: '_SchedulePageControllerBase.listMaterias');

  @override
  ObservableFuture<List<SubjectModel>> get listMaterias {
    _$listMateriasAtom.reportRead();
    return super.listMaterias;
  }

  @override
  set listMaterias(ObservableFuture<List<SubjectModel>> value) {
    _$listMateriasAtom.reportWrite(value, super.listMaterias, () {
      super.listMaterias = value;
    });
  }

  final _$_daySelectedAtom =
      Atom(name: '_SchedulePageControllerBase._daySelected');

  @override
  int get _daySelected {
    _$_daySelectedAtom.reportRead();
    return super._daySelected;
  }

  @override
  set _daySelected(int value) {
    _$_daySelectedAtom.reportWrite(value, super._daySelected, () {
      super._daySelected = value;
    });
  }

  final _$_SchedulePageControllerBaseActionController =
      ActionController(name: '_SchedulePageControllerBase');

  @override
  void changeDaySelected(int day) {
    final _$actionInfo = _$_SchedulePageControllerBaseActionController
        .startAction(name: '_SchedulePageControllerBase.changeDaySelected');
    try {
      return super.changeDaySelected(day);
    } finally {
      _$_SchedulePageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListHorarios(List<ScheduleModel> _horarios) {
    final _$actionInfo = _$_SchedulePageControllerBaseActionController
        .startAction(name: '_SchedulePageControllerBase.setListHorarios');
    try {
      return super.setListHorarios(_horarios);
    } finally {
      _$_SchedulePageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listHorario: ${listHorario},
listMaterias: ${listMaterias}
    ''';
  }
}
