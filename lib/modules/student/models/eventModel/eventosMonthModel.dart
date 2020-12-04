import 'package:escol/modules/student/models/eventModel/eventDayModel.dart';

class EventMonthModel {
  DateTime month;
  List<EventDayModel> events;

  EventMonthModel({
    this.month,
    this.events,
  });
}
