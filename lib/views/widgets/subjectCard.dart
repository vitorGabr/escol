import 'package:escol/modules/student/models/subjectModel.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:flutter/material.dart';

import '../shared/general/theme/colors.dart';

class SubjectCard extends StatelessWidget {
  final SubjectModel subject;

  const SubjectCard({Key key, this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppConfig _ac;
    _ac = AppConfig(context);
    return Container(
      margin: EdgeInsets.only(right: _ac.rWP(2.5)),
      width: _ac.rW(22),
      decoration: BoxDecoration(
          color: neutralDarker,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: primaryshadow, offset: Offset(0, 3), blurRadius: 5.0)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(horizontal: _ac.rWP(2)),
            child: FittedBox(
              child: Text(
                '${subject.shortName.toUpperCase()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: primary, fontSize: 30, fontWeight: FontWeight.bold),
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
              '${subject.teacher}',
              textAlign: TextAlign.right,
              style: TextStyle(color: primary, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
