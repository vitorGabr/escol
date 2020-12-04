import 'package:escol/modules/student/models/eventModel/eventModel.dart';

class EventDayModel {
  DateTime day;
  List<EventModel> events;

  EventDayModel({
    this.day,
    this.events,
  });
}
