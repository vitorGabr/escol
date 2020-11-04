import 'package:escol/modules/shared/models/facebookPostsModel.dart';

class FacebookModel {
  String id;
  String name;
  FacebookPostsModel posts;

  FacebookModel({
    this.id,
    this.posts,
  });

  factory FacebookModel.fromJson(Map<String, dynamic> json) => FacebookModel(
    id: json['id'] == null ? null : json['id'],
    posts: json['posts'] == null ? null : FacebookPostsModel.fromJson(json['posts']),
  );

  Map<String, dynamic> toJson({bool dateToString = false}) => {
    'id': id == null ? null : id,
    'posts': posts == null ? null : posts,
  };
}