// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendarPageController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CalendarPageController on _CalendarPageControllerBase, Store {
  final _$eventListAtom = Atom(name: '_CalendarPageControllerBase.eventList');

  @override
  ObservableFuture<List<EventMonthModel>> get eventList {
    _$eventListAtom.reportRead();
    return super.eventList;
  }

  @override
  set eventList(ObservableFuture<List<EventMonthModel>> value) {
    _$eventListAtom.reportWrite(value, super.eventList, () {
      super.eventList = value;
    });
  }

  final _$selectedEventsAtom =
      Atom(name: '_CalendarPageControllerBase.selectedEvents');

  @override
  Map<DateTime, List<dynamic>> get selectedEvents {
    _$selectedEventsAtom.reportRead();
    return super.selectedEvents;
  }

  @override
  set selectedEvents(Map<DateTime, List<dynamic>> value) {
    _$selectedEventsAtom.reportWrite(value, super.selectedEvents, () {
      super.selectedEvents = value;
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
eventList: ${eventList},
selectedEvents: ${selectedEvents}
    ''';
  }
}
