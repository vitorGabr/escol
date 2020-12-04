class ClassroomModel {
  int classesNumber;
  int grade;
  String group;

  ClassroomModel({
    this.classesNumber,
    this.grade,
    this.group,
  });

  factory ClassroomModel.fromJson(Map<String, dynamic> json) => ClassroomModel(
        classesNumber: json['numeroAulas'] == null ? null : json['numeroAulas'],
        grade: json['serie'] == null ? null : json['serie'],
        group: json['turma'] == null ? null : json['turma'],
      );

  Map<String, dynamic> toJson({bool dateToString = false}) => {
        'numeroAulas': classesNumber == null ? null : classesNumber,
        'serie': grade == null ? null : grade,
        'turma': group == null ? null : group,
      };
}
