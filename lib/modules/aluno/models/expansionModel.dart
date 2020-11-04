import 'package:escol/modules/aluno/models/aulaModel.dart';

class ExpansionModel {

  ExpansionModel({this.isExpanded: false,this.header, this.body});

  bool isExpanded;
  final String header;
  final List<AulaModel> body;
}