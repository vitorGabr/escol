import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DiasCard extends StatelessWidget {

  final String dia;
  final String data;
  final bool isSelected;
  final Function callback;

  const DiasCard({Key key, 
    @required this.dia, 
    @required this.data, 
    @required this.isSelected,
    @required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    AppConfig _ac = AppConfig(context);
    return Container(
      margin: EdgeInsets.only(right: _ac.rWP(5)),
      width: _ac.rW(21),
      decoration: BoxDecoration(
        color: isSelected ? secondaryColor : neutralLighter,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: primaryshadow,
            offset: Offset(0,4),
            blurRadius: 5.0
          )
        ]
      ),
      child: RaisedButton(
        padding: EdgeInsets.zero,
        color: isSelected ? secondaryColor : neutralLighter,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        onPressed: () => callback(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${toBeginningOfSentenceCase(dia)}',
              style: TextStyle(
                color: isSelected ? primary : secondary,
                fontWeight: FontWeight.bold,
                fontSize: 34
              ),
            ),
            Text(
              '$data',
              style: TextStyle(
                color: isSelected ? primary : secondary,
                fontSize: 15
              ),
            ),
          ],
        ),
      ),
    );
  }
}