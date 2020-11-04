// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horarioEditModalController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HorarioEditModalController on _HorarioEditModalControllerBase, Store {
  final _$_daySelectedAtom =
      Atom(name: '_HorarioEditModalControllerBase._daySelected');

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
      Atom(name: '_HorarioEditModalControllerBase._dropDownValue');

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
      Atom(name: '_HorarioEditModalControllerBase.listHorarios');

  @override
  ObservableList<HorarioModel> get listHorarios {
    _$listHorariosAtom.reportRead();
    return super.listHorarios;
  }

  @override
  set listHorarios(ObservableList<HorarioModel> value) {
    _$listHorariosAtom.reportWrite(value, super.listHorarios, () {
      super.listHorarios = value;
    });
  }

  final _$isLoadedAtom = Atom(name: '_HorarioEditModalControllerBase.isLoaded');

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
      Atom(name: '_HorarioEditModalControllerBase.listMaterias');

  @override
  ObservableList<MateriaModel> get listMaterias {
    _$listMateriasAtom.reportRead();
    return super.listMaterias;
  }

  @override
  set listMaterias(ObservableList<MateriaModel> value) {
    _$listMateriasAtom.reportWrite(value, super.listMaterias, () {
      super.listMaterias = value;
    });
  }

  final _$_HorarioEditModalControllerBaseActionController =
      ActionController(name: '_HorarioEditModalControllerBase');

  @override
  dynamic changeDaySelected(int day) {
    final _$actionInfo = _$_HorarioEditModalControllerBaseActionController
        .startAction(name: '_HorarioEditModalControllerBase.changeDaySelected');
    try {
      return super.changeDaySelected(day);
    } finally {
      _$_HorarioEditModalControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeDropDownValue(String _newValue) {
    final _$actionInfo =
        _$_HorarioEditModalControllerBaseActionController.startAction(
            name: '_HorarioEditModalControllerBase.changeDropDownValue');
    try {
      return super.changeDropDownValue(_newValue);
    } finally {
      _$_HorarioEditModalControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setListMaterias(List<MateriaModel> _newList) {
    final _$actionInfo = _$_HorarioEditModalControllerBaseActionController
        .startAction(name: '_HorarioEditModalControllerBase.setListMaterias');
    try {
      return super.setListMaterias(_newList);
    } finally {
      _$_HorarioEditModalControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setListHorarios(List<HorarioModel> _newList) {
    final _$actionInfo = _$_HorarioEditModalControllerBaseActionController
        .startAction(name: '_HorarioEditModalControllerBase.setListHorarios');
    try {
      return super.setListHorarios(_newList);
    } finally {
      _$_HorarioEditModalControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeHorario(String _value, int idx) {
    final _$actionInfo = _$_HorarioEditModalControllerBaseActionController
        .startAction(name: '_HorarioEditModalControllerBase.changeHorario');
    try {
      return super.changeHorario(_value, idx);
    } finally {
      _$_HorarioEditModalControllerBaseActionController.endAction(_$actionInfo);
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
