import 'package:cloud_firestore/cloud_firestore.dart';

class SchoolInformationModel {
  DocumentReference school;
  DocumentReference classroom;

  SchoolInformationModel({
    this.school,
    this.classroom,
  });

  factory SchoolInformationModel.fromJson(Map<String, dynamic> json) =>
      SchoolInformationModel(
        school: json['escola'] == null ? null : json['escola'],
        classroom: json['sala'] == null ? null : json['sala'],
      );

  Map<String, dynamic> toJson({bool dateToString = false}) => {
        'escola': school == null ? null : school,
        'sala': classroom == null ? null : classroom,
      };
}
