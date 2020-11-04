enum CategoriaEnum {
 importante,
 escola,
 todas,
 emprego,
 sala
}

const Map<CategoriaEnum, dynamic> GetNameCategoriaEnum = {
  CategoriaEnum.importante: 'Importante',
  CategoriaEnum.emprego: 'Emprego',
  CategoriaEnum.escola: 'Escola',
  CategoriaEnum.sala: 'Sala',
  CategoriaEnum.todas: 'Todas',
};
