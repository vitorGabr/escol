class SchoolModel {
  String city;
  String state;
  String name;

  SchoolModel({
    this.city,
    this.state,
    this.name,
  });

  factory SchoolModel.fromJson(Map<String, dynamic> json) => SchoolModel(
        city: json['cidade'] == null ? null : json['cidade'],
        state: json['estado'] == null ? null : json['estado'],
        name: json['nome'] == null ? null : json['nome'],
      );

  Map<String, dynamic> toJson({bool dateToString = false}) => {
        'cidade': city == null ? null : city,
        'estado': state == null ? null : state,
        'nome': name == null ? null : name,
      };
}
