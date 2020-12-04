import 'package:escol/modules/student/models/classModel.dart';

class ScheduleModel {
  int weekDay;
  List<ClassModel> classes;

  ScheduleModel({
    this.weekDay,
    this.classes,
  });
}
