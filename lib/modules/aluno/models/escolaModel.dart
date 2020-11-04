
class EscolaModel {

  String cidade;
  String estado;
  String nome;

  EscolaModel({
    this.cidade,
    this.estado,
    this.nome,
  });

  factory EscolaModel.fromJson(Map<String, dynamic> json) => EscolaModel(
    cidade: json['cidade'] == null ? null : json['cidade'],
    estado: json['estado'] == null ? null : json['estado'],
    nome: json['nome'] == null ? null : json['nome'],
  );

  Map<String, dynamic> toJson({bool dateToString = false}) => {
    'cidade': cidade == null ? null : cidade,
    'estado': estado == null ? null : estado,
    'nome': nome == null ? null : nome,
  };


}