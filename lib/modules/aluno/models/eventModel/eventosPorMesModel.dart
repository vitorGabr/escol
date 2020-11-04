import 'package:escol/modules/aluno/models/eventModel/eventosPorDiaModel.dart';

class EventosPorMesModel {

  DateTime mes;
  List<EventosPorDiaModel> eventos;

  EventosPorMesModel({
    this.mes,
    this.eventos,
  });

}