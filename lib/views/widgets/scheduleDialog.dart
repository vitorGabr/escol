import 'package:auto_size_text/auto_size_text.dart';
import 'package:escol/modules/student/models/subjectModel.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class ScheduleDialog extends StatelessWidget {
  final SubjectModel subject;
  final List<SubjectModel> listSubject;
  final int idx;

  const ScheduleDialog({
    Key key,
    @required this.subject,
    @required this.idx,
    @required this.listSubject,
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
                '${toBeginningOfSentenceCase(subject.name)}',
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style: TextStyle(
                    color: secondary,
                    fontSize: 45,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: _ac.rH(5),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                'Prof: ${subject.teacher}',
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
