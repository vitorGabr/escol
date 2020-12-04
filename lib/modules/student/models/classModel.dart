class ClassModel {
  String subject;
  String teacher;
  bool isExpanded = false;

  ClassModel({
    this.subject,
    this.teacher,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
        subject: json['materia'] == null ? null : json['materia'],
        teacher: json['professor'] == null ? null : json['professor'],
      );

  Map<String, dynamic> toJson({bool dateToString = false}) => {
        'materia': subject == null ? null : subject,
        'professor': teacher == null ? null : teacher,
      };
}
