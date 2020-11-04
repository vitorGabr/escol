import 'package:escol/modules/shared/models/facebookPostContentModel.dart';

class FacebookPostsModel {
  List<FacebookPostsContentModel> data;

  FacebookPostsModel({
    this.data,
  });

  factory FacebookPostsModel.fromJson(Map<String, dynamic> json) => FacebookPostsModel(
    data: json['data'] == null ? null : new List<FacebookPostsContentModel>.from(
      json['data'].map((_posts) => FacebookPostsContentModel.fromJson(_posts)).toList()) ,
  );
}