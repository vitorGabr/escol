import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectModel {
  String name;
  String shortName;
  String teacher;
  DocumentReference reference;

  SubjectModel({
    this.shortName,
    this.name,
    this.teacher,
    this.reference,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
        name: json['nome'] == null ? null : json['nome'],
        teacher: json['professor'] == null ? null : json['professor'],
        shortName: json['nomeAbreviado'] == null ? null : json['nomeAbreviado'],
        reference: json['referencia'] == null ? null : json['referencia'],
      );

  Map<String, dynamic> toJson({bool dateToString = false}) => {
        'nome': name == null ? null : name,
        'professor': teacher == null ? null : teacher,
        'nomeAbreviado': shortName == null ? null : shortName,
        'referencia': reference == null ? null : reference,
      };
}
