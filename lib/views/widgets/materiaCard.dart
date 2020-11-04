import 'package:escol/modules/aluno/models/materiaModel.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:flutter/material.dart';

class MateriaCard extends StatelessWidget {

  final MateriaModel materia;

  const MateriaCard({Key key, this.materia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppConfig _ac;
    _ac = AppConfig(context);
    return Container(
      margin: EdgeInsets.only(right: _ac.rWP(4)),
      width: _ac.rW(20),
      decoration: BoxDecoration(
        color: neutralDarker,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: primaryshadow,
            offset: Offset(0,3),
            blurRadius: 5.0
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(horizontal: _ac.rWP(2)),
            child: FittedBox(
              child: Text(
                '${materia.nomeAbreviado.toUpperCase()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primary,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
          Container(
            width: _ac.rW(100),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: _ac.rWP(2)),
            child: Text(
              '${materia.professor}',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: primary,
                fontSize: 16
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}