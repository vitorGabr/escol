// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendarPageController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CalendarPageController on _CalendarPageControllerBase, Store {
  final _$listEventosAtom =
      Atom(name: '_CalendarPageControllerBase.listEventos');

  @override
  ObservableFuture<List<EventosPorMesModel>> get listEventos {
    _$listEventosAtom.reportRead();
    return super.listEventos;
  }

  @override
  set listEventos(ObservableFuture<List<EventosPorMesModel>> value) {
    _$listEventosAtom.reportWrite(value, super.listEventos, () {
      super.listEventos = value;
    });
  }

  final _$calendarEventsAtom =
      Atom(name: '_CalendarPageControllerBase.calendarEvents');

  @override
  Map<DateTime, List<dynamic>> get calendarEvents {
    _$calendarEventsAtom.reportRead();
    return super.calendarEvents;
  }

  @override
  set calendarEvents(Map<DateTime, List<dynamic>> value) {
    _$calendarEventsAtom.reportWrite(value, super.calendarEvents, () {
      super.calendarEvents = value;
    });
  }

  final _$_CalendarPageControllerBaseActionController =
      ActionController(name: '_CalendarPageControllerBase');

  @override
  void transformInEvents() {
    final _$actionInfo = _$_CalendarPageControllerBaseActionController
        .startAction(name: '_CalendarPageControllerBase.transformInEvents');
    try {
      return super.transformInEvents();
    } finally {
      _$_CalendarPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listEventos: ${listEventos},
calendarEvents: ${calendarEvents}
    ''';
  }
}
