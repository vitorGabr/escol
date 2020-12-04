import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  String description;
  String image;
  DateTime data;
  DocumentReference user;
  String userImage;
  String userName;
  List<int> category;

  NewsModel({
    this.userImage,
    this.userName,
    this.description,
    this.image,
    this.data,
    this.user,
    this.category,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        userImage:
            json['usuario_imagem'] == null ? null : json['usuario_imagem'],
        category: json['categorias'] == null
            ? null
            : List<int>.from(json['categorias']),
        userName: json['usuario_nome'] == null ? null : json['usuario_nome'],
        description: json['descricao'] == null ? null : json['descricao'],
        image: json['imagem'] == null ? null : json['imagem'],
        data:
            json['data'] == null ? null : (json['data'] as Timestamp).toDate(),
        user: json['usuario'] == null ? null : json['usuario'],
      );

  Map<String, dynamic> toJson() => {
        'usuario_imagem': userImage == null ? null : userImage,
        'categorias': category == null ? null : category,
        'usuario_nome': userName == null ? null : userName,
        'data': data == null ? null : data,
        'usuario': user == null ? null : user,
        'descricao': description == null ? null : description,
        'imagem': image == null ? null : image,
      };
}
