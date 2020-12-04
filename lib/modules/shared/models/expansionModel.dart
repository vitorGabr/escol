import 'package:escol/modules/student/models/classModel.dart';

class ExpansionModel {
  ExpansionModel({this.isExpanded: false, this.header, this.body});

  bool isExpanded;
  final String header;
  final List<ClassModel> body;
}
