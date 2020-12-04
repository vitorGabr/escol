import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String title;
  String subject;
  DateTime date;
  String description;

  EventModel({
    this.title,
    this.subject,
    this.date,
    this.description,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        title: json['titulo'] == null ? null : json['titulo'],
        subject: json['materia'] == null ? null : json['materia'],
        date:
            json['data'] == null ? null : (json['data'] as Timestamp).toDate(),
        description: json['descricao'] == null ? null : json['descricao'],
      );

  Map<String, dynamic> toJson({bool dateToString = false}) => {
        'titulo': title == null ? null : title,
        'materia': subject == null ? null : subject,
        'data': date == null ? null : date,
        'descricao': description == null ? null : description,
      };
}
