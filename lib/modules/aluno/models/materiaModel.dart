
import 'package:cloud_firestore/cloud_firestore.dart';

class MateriaModel {

  String nome;
  String nomeAbreviado;
  String img;
  String professor;
  DocumentReference referencia;

  MateriaModel({
    this.nomeAbreviado,
    this.nome,
    this.professor,
    this.img,
    this.referencia,
  });

  factory MateriaModel.fromJson(Map<String, dynamic> json) => MateriaModel(
    nome: json['nome'] == null ? null : json['nome'],
    professor: json['professor'] == null ? null : json['professor'],
    nomeAbreviado: json['nomeAbreviado'] == null ? null : json['nomeAbreviado'],
    img: json['img'] == null ? null : json['img'],
    referencia: json['referencia'] == null ? null : json['referencia'],
  );

  Map<String, dynamic> toJson({bool dateToString = false}) => {
    'nome': nome == null ? null : nome,
    'professor': professor == null ? null : professor,
    'nomeAbreviado': nomeAbreviado == null ? null : nomeAbreviado,
    'img': img == null ? null : img,
    'referencia': referencia == null ? null : referencia,
  };


}