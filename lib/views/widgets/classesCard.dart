import 'package:escol/modules/student/models/classModel.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:flutter/material.dart';

import '../shared/general/theme/colors.dart';

class ClassCard extends StatelessWidget {
  final int idx;
  final ClassModel classes;

  const ClassCard({Key key, this.idx, this.classes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppConfig _ac = AppConfig(context);
    return Container(
      width: _ac.rW(14),
      height: _ac.rW(10),
      margin: EdgeInsets.only(right: idx != 4 ? _ac.rWP(5.5) : 0),
      decoration: BoxDecoration(
        color: neutralLighter,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                ),
              ),
              child: Text(
                '${classes.subject.toUpperCase()}',
                style: TextStyle(
                    color: secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              width: _ac.rW(100),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: Text(
                '${idx + 1}º A',
                style: TextStyle(
                    color: primary, fontWeight: FontWeight.bold, fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }
}
