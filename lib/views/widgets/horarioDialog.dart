import 'package:auto_size_text/auto_size_text.dart';
import 'package:escol/modules/aluno/models/materiaModel.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class HorarioDialog extends StatelessWidget {

  final MateriaModel materia;
  final List<MateriaModel> listMateria;
  final int idx;

  const HorarioDialog({
    Key key,  
    @required this.materia, 
    @required this.idx, 
    @required this.listMateria, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppConfig _ac = AppConfig(context);
    return AlertDialog(
      backgroundColor: primary,
      content: Container(
        height: _ac.rH(35),
        width: _ac.rW(80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$idx\º Aula',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: _ac.rH(3),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: _ac.rH(20),
              child: AutoSizeText(
                '${toBeginningOfSentenceCase(materia.nome)}',
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style: TextStyle(
                  color: secondary,
                  fontSize: 45,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            // DropdownButton(
            //   value: dropdownValue,
            //   isExpanded: true,
            //   elevation: 0,
            //   style: TextStyle(color: secondary,fontSize: 45,), 
            //   onChanged: (String newValue) {},
            //   underline: Container(height: 0,),
            //   items: _listNomeMaterias.map<DropdownMenuItem<String>>((String value) {
            //     return DropdownMenuItem<String>(
            //       value: value,
            //       child: AutoSizeText(
            //         '${toBeginningOfSentenceCase(value)}',
            //         maxLines: 4,
            //         style: TextStyle(
            //           color: secondary,
            //           fontSize: 20,
            //           fontWeight: FontWeight.bold
            //         ),
            //       ),
            //     );
            //   }).toList(),
            // ),
            SizedBox(
              height: _ac.rH(5),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                'Prof: ${materia.professor}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}