import 'dart:async';

import 'package:escol/modules/aluno/models/eventModel/eventosPorDiaModel.dart';
import 'package:escol/modules/aluno/models/eventModel/eventosPorMesModel.dart';
import 'package:escol/modules/firebase/repositories/firebaseFirestoreRepository.dart';
import 'package:mobx/mobx.dart';
part 'calendarPageController.g.dart';

class CalendarPageController = _CalendarPageControllerBase with _$CalendarPageController;

abstract class _CalendarPageControllerBase with Store {
  
  _CalendarPageControllerBase(String _uid){
    getListEventos(_uid);
  }

  final FirebaseFirestoreRepository _firestoreRepository = FirebaseFirestoreRepository();

  @observable
  ObservableFuture<List<EventosPorMesModel>> listEventos;
  
  @observable
  Map<DateTime, List<dynamic>> calendarEvents = {};

  @action
  void transformInEvents(){
    listEventos.value.forEach((_result) { 
      _result.eventos.forEach((_value) { 
        calendarEvents[_value.dia] = _value.eventos;
      });
    });
  }

  void getListEventos(String _uid){
    listEventos = _firestoreRepository.getListEventos(_uid).asObservable();
  }

  void filterEvents(DateTime _newDate, List _newListEventos){
    var _completer = Completer<List<EventosPorMesModel>>();
    var filteredEventsDia = EventosPorDiaModel()
      ..dia = _newDate
      ..eventos = _newListEventos.isEmpty ? [] : _newListEventos;
    var filteredEventsMes = EventosPorMesModel()
      ..mes = _newDate
      ..eventos = [filteredEventsDia];
    listEventos = _completer.future.asObservable();
    _completer.complete([filteredEventsMes]);
  }
}