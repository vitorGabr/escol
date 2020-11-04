class FacebookPostsContentModel {
  String fullPicture;
  String id;
  String message;

  FacebookPostsContentModel({
    this.fullPicture,
    this.id,
    this.message,
  });

  factory FacebookPostsContentModel.fromJson(Map<String, dynamic> json) => FacebookPostsContentModel(
    fullPicture: json['full_picture'] == null ? null : json['full_picture'],
    id: json['id'] == null ? null : json['id'],
    message: json['message'] == null ? 'null' : json['message'],
  );

  Map<String, dynamic> toJson({bool dateToString = false}) => {
    'full_picture': fullPicture == null ? null : fullPicture,
    'id': id == null ? null : id,
    'message': message == null ? null : message,
  };
}