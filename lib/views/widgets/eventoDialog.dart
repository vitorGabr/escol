import 'package:escol/modules/aluno/models/eventModel/eventoModel.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:flutter/material.dart';

class EventoDialog extends StatelessWidget {

  final EventoModel evento;


  const EventoDialog({
    Key key, this.evento,  
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
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${evento.data.hour}:${evento.data.minute}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: _ac.rH(2)),
            Text(
              '${evento.titulo}',
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              style: TextStyle(
                color: secondary,
                fontSize: 40,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: _ac.rH(2)),
            Text(
              '${evento.descricao}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: _ac.rH(2)),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${evento.materia.toUpperCase()}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}