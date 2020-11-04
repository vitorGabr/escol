import 'package:cloud_firestore/cloud_firestore.dart';

class NoticiaModel {

  String descricao;
  String imagem;
  DateTime data;
  DocumentReference usuario;
  String usuarioImage;
  String usuarioNome;
  List<int> categorias;

  NoticiaModel({
    this.usuarioImage,
    this.usuarioNome,
    this.descricao,
    this.imagem,
    this.data,
    this.usuario,
    this.categorias,
  });

  factory NoticiaModel.fromJson(Map<String, dynamic> json) => NoticiaModel(
    usuarioImage: json['usuario_imagem'] == null ? null : json['usuario_imagem'],
    categorias: json['categorias'] == null ? null : List<int>.from(json['categorias']),
    usuarioNome: json['usuario_nome'] == null ? null : json['usuario_nome'],
    descricao: json['descricao'] == null ? null : json['descricao'],
    imagem: json['imagem'] == null ? null : json['imagem'],
    data: json['data'] == null ? null : (json['data'] as Timestamp).toDate(),
    usuario: json['usuario'] == null ? null : json['usuario'],
  );

  Map<String, dynamic> toJson() => {
    'usuario_imagem': usuarioImage == null ? null : usuarioImage,
    'categorias': categorias == null ? null : categorias,
    'usuario_nome': usuarioNome == null ? null : usuarioNome,
    'data': data == null ? null : data,
    'usuario': usuario == null ? null : usuario,
    'descricao': descricao == null ? null : descricao,
    'imagem': imagem == null ? null : imagem,
  };

}