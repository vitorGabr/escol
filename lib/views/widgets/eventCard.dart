import 'package:escol/modules/student/models/eventModel/eventModel.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:escol/views/widgets/eventDialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../shared/general/theme/colors.dart';

class EventCard extends StatelessWidget {
  final EventModel event;
  final String time;

  EventCard({
    Key key,
    @required this.event,
    @required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppConfig _ac = AppConfig(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          '$time',
          style: TextStyle(
            fontSize: 18,
            color: secondary,
          ),
        ),
        Container(
          width: _ac.rW(75),
          margin: EdgeInsets.symmetric(vertical: _ac.rWP(1)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: primaryshadow, offset: Offset(0, 4), blurRadius: 5.0)
              ]),
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
            color: secondaryColor,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return EventDialog(
                      event: event,
                    );
                  });
            },
            padding: EdgeInsets.symmetric(
                vertical: _ac.rHP(2), horizontal: _ac.rWP(2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: _ac.rW(100),
                  child: Text(
                    '${toBeginningOfSentenceCase(event.title)}',
                    style: TextStyle(
                        color: primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: _ac.rW(100),
                  child: Text(
                    '${toBeginningOfSentenceCase(event.description)}',
                    style: TextStyle(
                      color: primary,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
