
import 'package:cloud_firestore/cloud_firestore.dart';

class InformacaoEscolarModel {

  DocumentReference escola;
  DocumentReference sala;

  InformacaoEscolarModel({
    this.escola,
    this.sala,
  });

  factory InformacaoEscolarModel.fromJson(Map<String, dynamic> json) => InformacaoEscolarModel(
    escola: json['escola'] == null ? null : json['escola'],
    sala: json['sala'] == null ? null : json['sala'],
  );

  Map<String, dynamic> toJson({bool dateToString = false}) => {
    'escola': escola == null ? null : escola,
    'sala': sala == null ? null : sala,
  };


}