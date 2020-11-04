
class SalaModel {

  int numeroAulas;
  int serie;
  String turma;

  SalaModel({
    this.numeroAulas,
    this.serie,
    this.turma,
  });

  factory SalaModel.fromJson(Map<String, dynamic> json) => SalaModel(
    numeroAulas: json['numeroAulas'] == null ? null : json['numeroAulas'],
    serie: json['serie'] == null ? null : json['serie'],
    turma: json['turma'] == null ? null : json['turma'],
  );

  Map<String, dynamic> toJson({bool dateToString = false}) => {
    'numeroAulas': numeroAulas == null ? null : numeroAulas,
    'serie': serie == null ? null : serie,
    'turma': turma == null ? null : turma,
  };


}