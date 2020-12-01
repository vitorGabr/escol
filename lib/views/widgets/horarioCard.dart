import 'package:auto_size_text/auto_size_text.dart';
import 'package:escol/modules/aluno/models/materiaModel.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:escol/views/widgets/horarioDialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../shared/general/theme/colors.dart';

class HorarioCard extends StatelessWidget {
  final int idx;
  final String materia;
  final List<MateriaModel> listMateria;
  final String prof;
  final MateriaModel materiaCompleta;

  const HorarioCard(
      {Key key,
      @required this.idx,
      @required this.materia,
      @required this.prof,
      @required this.materiaCompleta,
      @required this.listMateria})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppConfig _ac = AppConfig(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: _ac.rHP(1)),
      height: _ac.rH(9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: primaryshadow,
                        offset: Offset(0, 4),
                        blurRadius: 5)
                  ]),
              child: RaisedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return HorarioDialog(
                          listMateria: listMateria,
                          materia: materiaCompleta,
                          idx: idx,
                        );
                      });
                },
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: secondary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: _ac.rW(75),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            '$idx\º aula',
                            style: TextStyle(color: primary, fontSize: 15),
                          ),
                          Text(
                            '${toBeginningOfSentenceCase(materiaCompleta.nome)}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                color: primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 26),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Icon(
                        Icons.arrow_forward,
                        color: primary,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
