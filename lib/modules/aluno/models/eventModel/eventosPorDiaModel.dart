import 'package:escol/modules/aluno/models/eventModel/eventoModel.dart';

class EventosPorDiaModel {

  DateTime dia;
  List<EventoModel> eventos;


  EventosPorDiaModel({
    this.dia,
    this.eventos,
  });
}