// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendarModalController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CalendarModalController on _CalendarModalControllerBase, Store {
  final _$salaAtom = Atom(name: '_CalendarModalControllerBase.sala');

  @override
  ObservableFuture<SalaModel> get sala {
    _$salaAtom.reportRead();
    return super.sala;
  }

  @override
  set sala(ObservableFuture<SalaModel> value) {
    _$salaAtom.reportWrite(value, super.sala, () {
      super.sala = value;
    });
  }

  final _$materiasAtom = Atom(name: '_CalendarModalControllerBase.materias');

  @override
  ObservableFuture<List<MateriaModel>> get materias {
    _$materiasAtom.reportRead();
    return super.materias;
  }

  @override
  set materias(ObservableFuture<List<MateriaModel>> value) {
    _$materiasAtom.reportWrite(value, super.materias, () {
      super.materias = value;
    });
  }

  final _$aulasAtom = Atom(name: '_CalendarModalControllerBase.aulas');

  @override
  ObservableList<String> get aulas {
    _$aulasAtom.reportRead();
    return super.aulas;
  }

  @override
  set aulas(ObservableList<String> value) {
    _$aulasAtom.reportWrite(value, super.aulas, () {
      super.aulas = value;
    });
  }

  final _$isLoadedAtom = Atom(name: '_CalendarModalControllerBase.isLoaded');

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

  final _$_selectedDateAtom =
      Atom(name: '_CalendarModalControllerBase._selectedDate');

  @override
  DateTime get _selectedDate {
    _$_selectedDateAtom.reportRead();
    return super._selectedDate;
  }

  @override
  set _selectedDate(DateTime value) {
    _$_selectedDateAtom.reportWrite(value, super._selectedDate, () {
      super._selectedDate = value;
    });
  }

  final _$_selectedTimeAtom =
      Atom(name: '_CalendarModalControllerBase._selectedTime');

  @override
  TimeOfDay get _selectedTime {
    _$_selectedTimeAtom.reportRead();
    return super._selectedTime;
  }

  @override
  set _selectedTime(TimeOfDay value) {
    _$_selectedTimeAtom.reportWrite(value, super._selectedTime, () {
      super._selectedTime = value;
    });
  }

  final _$_dropdownAtom = Atom(name: '_CalendarModalControllerBase._dropdown');

  @override
  String get _dropdown {
    _$_dropdownAtom.reportRead();
    return super._dropdown;
  }

  @override
  set _dropdown(String value) {
    _$_dropdownAtom.reportWrite(value, super._dropdown, () {
      super._dropdown = value;
    });
  }

  final _$getInfoSalaAsyncAction =
      AsyncAction('_CalendarModalControllerBase.getInfoSala');

  @override
  Future<void> getInfoSala(String _uid) {
    return _$getInfoSalaAsyncAction.run(() => super.getInfoSala(_uid));
  }

  final _$_CalendarModalControllerBaseActionController =
      ActionController(name: '_CalendarModalControllerBase');

  @override
  dynamic changePicked(DateTime _date) {
    final _$actionInfo = _$_CalendarModalControllerBaseActionController
        .startAction(name: '_CalendarModalControllerBase.changePicked');
    try {
      return super.changePicked(_date);
    } finally {
      _$_CalendarModalControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeTimePicked(TimeOfDay _time) {
    final _$actionInfo = _$_CalendarModalControllerBaseActionController
        .startAction(name: '_CalendarModalControllerBase.changeTimePicked');
    try {
      return super.changeTimePicked(_time);
    } finally {
      _$_CalendarModalControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeDropdown(String _newValue) {
    final _$actionInfo = _$_CalendarModalControllerBaseActionController
        .startAction(name: '_CalendarModalControllerBase.changeDropdown');
    try {
      return super.changeDropdown(_newValue);
    } finally {
      _$_CalendarModalControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
sala: ${sala},
materias: ${materias},
aulas: ${aulas},
isLoaded: ${isLoaded}
    ''';
  }
}
