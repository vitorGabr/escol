import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../shared/general/theme/colors.dart';

class DayCard extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;
  final Function callback;

  const DayCard({
    Key key,
    @required this.day,
    @required this.date,
    @required this.isSelected,
    @required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppConfig _ac = AppConfig(context);
    return Container(
      margin: EdgeInsets.only(right: _ac.rWP(3)),
      width: _ac.rW(21),
      decoration: BoxDecoration(
        color: isSelected ? secondaryColor : neutralLighter,
        borderRadius: BorderRadius.circular(12),
      ),
      child: RaisedButton(
        padding: EdgeInsets.zero,
        color: isSelected ? secondaryColor : neutralLighter,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onPressed: () => callback(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${toBeginningOfSentenceCase(day)}',
              style: TextStyle(
                  color: isSelected ? primary : secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 34),
            ),
            Text(
              '$date',
              style: TextStyle(
                  color: isSelected ? primary : secondary, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
