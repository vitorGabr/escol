import 'package:cloud_firestore/cloud_firestore.dart';

class EventoModel {

  String titulo;
  String materia;
  DateTime data;
  String descricao;
  String aula;


  EventoModel({
    this.titulo,
    this.materia,
    this.data,
    this.descricao,
    this.aula,
  });

  factory EventoModel.fromJson(Map<String, dynamic> json) => EventoModel(
    titulo: json['titulo'] == null ? null : json['titulo'],
    materia: json['materia'] == null ? null : json['materia'],
    aula: json['aula'] == null ? null : json['aula'],
    data: json['data'] == null ? null : (json['data'] as Timestamp).toDate(),
    descricao: json['descricao'] == null ? null : json['descricao'],
  );

  Map<String, dynamic> toJson({bool dateToString = false}) => {
    'titulo': titulo == null ? null : titulo,
    'materia': materia == null ? null : materia,
    'aula': aula == null ? null : aula,
    'data': data == null ? null : data,
    'descricao': descricao == null ? null : descricao,
  };

}