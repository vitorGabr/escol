// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horarioPageController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HorarioPageController on _HorarioPageControllerBase, Store {
  final _$listHorarioAtom =
      Atom(name: '_HorarioPageControllerBase.listHorario');

  @override
  ObservableFuture<List<HorarioModel>> get listHorario {
    _$listHorarioAtom.reportRead();
    return super.listHorario;
  }

  @override
  set listHorario(ObservableFuture<List<HorarioModel>> value) {
    _$listHorarioAtom.reportWrite(value, super.listHorario, () {
      super.listHorario = value;
    });
  }

  final _$listMateriasAtom =
      Atom(name: '_HorarioPageControllerBase.listMaterias');

  @override
  ObservableFuture<List<MateriaModel>> get listMaterias {
    _$listMateriasAtom.reportRead();
    return super.listMaterias;
  }

  @override
  set listMaterias(ObservableFuture<List<MateriaModel>> value) {
    _$listMateriasAtom.reportWrite(value, super.listMaterias, () {
      super.listMaterias = value;
    });
  }

  final _$_daySelectedAtom =
      Atom(name: '_HorarioPageControllerBase._daySelected');

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

  final _$_HorarioPageControllerBaseActionController =
      ActionController(name: '_HorarioPageControllerBase');

  @override
  void changeDaySelected(int day) {
    final _$actionInfo = _$_HorarioPageControllerBaseActionController
        .startAction(name: '_HorarioPageControllerBase.changeDaySelected');
    try {
      return super.changeDaySelected(day);
    } finally {
      _$_HorarioPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListHorarios(List<HorarioModel> _horarios) {
    final _$actionInfo = _$_HorarioPageControllerBaseActionController
        .startAction(name: '_HorarioPageControllerBase.setListHorarios');
    try {
      return super.setListHorarios(_horarios);
    } finally {
      _$_HorarioPageControllerBaseActionController.endAction(_$actionInfo);
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
