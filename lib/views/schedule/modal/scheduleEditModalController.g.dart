// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduleEditModalController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ScheduleEditModalController on _ScheduleEditModalControllerBase, Store {
  final _$_daySelectedAtom =
      Atom(name: '_ScheduleEditModalControllerBase._daySelected');

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

  final _$_dropDownValueAtom =
      Atom(name: '_ScheduleEditModalControllerBase._dropDownValue');

  @override
  String get _dropDownValue {
    _$_dropDownValueAtom.reportRead();
    return super._dropDownValue;
  }

  @override
  set _dropDownValue(String value) {
    _$_dropDownValueAtom.reportWrite(value, super._dropDownValue, () {
      super._dropDownValue = value;
    });
  }

  final _$listHorariosAtom =
      Atom(name: '_ScheduleEditModalControllerBase.listHorarios');

  @override
  ObservableList<ScheduleModel> get listHorarios {
    _$listHorariosAtom.reportRead();
    return super.listHorarios;
  }

  @override
  set listHorarios(ObservableList<ScheduleModel> value) {
    _$listHorariosAtom.reportWrite(value, super.listHorarios, () {
      super.listHorarios = value;
    });
  }

  final _$isLoadedAtom =
      Atom(name: '_ScheduleEditModalControllerBase.isLoaded');

  @override
  ObservableFuture<ResponseDefaultModel<dynamic>> get isLoaded {
    _$isLoadedAtom.reportRead();
    return super.isLoaded;
  }

  @override
  set isLoaded(ObservableFuture<ResponseDefaultModel<dynamic>> value) {
    _$isLoadedAtom.reportWrite(value, super.isLoaded, () {
      super.isLoaded = value;
    });
  }

  final _$listMateriasAtom =
      Atom(name: '_ScheduleEditModalControllerBase.listMaterias');

  @override
  ObservableList<SubjectModel> get listMaterias {
    _$listMateriasAtom.reportRead();
    return super.listMaterias;
  }

  @override
  set listMaterias(ObservableList<SubjectModel> value) {
    _$listMateriasAtom.reportWrite(value, super.listMaterias, () {
      super.listMaterias = value;
    });
  }

  final _$_ScheduleEditModalControllerBaseActionController =
      ActionController(name: '_ScheduleEditModalControllerBase');

  @override
  dynamic changeDaySelected(int day) {
    final _$actionInfo =
        _$_ScheduleEditModalControllerBaseActionController.startAction(
            name: '_ScheduleEditModalControllerBase.changeDaySelected');
    try {
      return super.changeDaySelected(day);
    } finally {
      _$_ScheduleEditModalControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeDropDownValue(String _newValue) {
    final _$actionInfo =
        _$_ScheduleEditModalControllerBaseActionController.startAction(
            name: '_ScheduleEditModalControllerBase.changeDropDownValue');
    try {
      return super.changeDropDownValue(_newValue);
    } finally {
      _$_ScheduleEditModalControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic setListMaterias(List<SubjectModel> _newList) {
    final _$actionInfo = _$_ScheduleEditModalControllerBaseActionController
        .startAction(name: '_ScheduleEditModalControllerBase.setListMaterias');
    try {
      return super.setListMaterias(_newList);
    } finally {
      _$_ScheduleEditModalControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic setListHorarios(List<ScheduleModel> _newList) {
    final _$actionInfo = _$_ScheduleEditModalControllerBaseActionController
        .startAction(name: '_ScheduleEditModalControllerBase.setListHorarios');
    try {
      return super.setListHorarios(_newList);
    } finally {
      _$_ScheduleEditModalControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeHorario(String _value, int idx) {
    final _$actionInfo = _$_ScheduleEditModalControllerBaseActionController
        .startAction(name: '_ScheduleEditModalControllerBase.changeHorario');
    try {
      return super.changeHorario(_value, idx);
    } finally {
      _$_ScheduleEditModalControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listHorarios: ${listHorarios},
isLoaded: ${isLoaded},
listMaterias: ${listMaterias}
    ''';
  }
}
