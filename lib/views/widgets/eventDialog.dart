import 'package:escol/modules/student/models/eventModel/eventModel.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:flutter/material.dart';

class EventDialog extends StatelessWidget {
  final EventModel event;

  const EventDialog({
    Key key,
    this.event,
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
                '${event.date.hour}:${event.date.minute}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: _ac.rH(2)),
            Text(
              '${event.title}',
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              style: TextStyle(
                  color: secondary, fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: _ac.rH(2)),
            Text(
              '${event.description}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: _ac.rH(2)),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${event.subject.toUpperCase()}',
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
