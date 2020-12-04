import 'package:auto_size_text/auto_size_text.dart';
import 'package:escol/modules/student/models/subjectModel.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:escol/views/widgets/scheduleDialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../shared/general/theme/colors.dart';

class ScheduleCard extends StatelessWidget {
  final int idx;
  final String subject;
  final List<SubjectModel> listSubject;
  final String teacher;
  final SubjectModel completeSubject;

  const ScheduleCard(
      {Key key,
      @required this.idx,
      @required this.subject,
      @required this.teacher,
      @required this.completeSubject,
      @required this.listSubject})
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
                        return ScheduleDialog(
                          listSubject: listSubject,
                          subject: completeSubject,
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
                            '${toBeginningOfSentenceCase(completeSubject.name)}',
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
