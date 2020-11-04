class AulaModel {

  String materia;
  String professor;
  bool isExpanded = false;

  AulaModel({
    this.materia,
    this.professor,
  });

  factory AulaModel.fromJson(Map<String, dynamic> json) => AulaModel(
    materia: json['materia'] == null ? null : json['materia'],
    professor: json['professor'] == null ? null : json['professor'],
  );

  Map<String, dynamic> toJson({bool dateToString = false}) => {
    'materia': materia == null ? null : materia,
    'professor': professor == null ? null : professor,
  };

}