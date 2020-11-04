import 'package:escol/modules/aluno/models/eventModel/eventosPorDiaModel.dart';
import 'package:escol/modules/aluno/models/eventModel/eventosPorMesModel.dart';
import 'package:escol/modules/firebase/models/firebaseUserModel.dart';
import 'package:escol/modules/shared/getItRepository.dart';
import 'package:escol/views/calendar/calendarPageController.dart';
import 'package:escol/views/calendar/modal/calendarModal.dart';
import 'package:escol/views/shared/circularIndicator/circularIndicator.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:escol/views/widgets/eventosCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  CalendarPageController _controller;
  final _user = locator.get<FirebaseUserModel>();

  @override
  void initState() {
    _controller = CalendarPageController(_user.uid);
    super.initState();
  }

  final _dayFormat = DateFormat('d EEEE', 'pt_BR');
  final _monthFormat = DateFormat('MMMM', 'pt_BR');

  CalendarController _calendarController = CalendarController();


  AppConfig _ac;
  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Calendário',
          style: TextStyle(
            color: secondary,
            fontSize: 20
          ),
        ),
        backgroundColor: primary,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: (){
          _awaitReturnValueFromSecondScreen(context);
        },
        tooltip: 'Increment',
        child: new Icon(Icons.edit_outlined,color: primary,),
        elevation: 4.0,
      ),
      body: Observer(
        builder: (_){
          if(_controller.listEventos.status == FutureStatus.pending){
            return CircularIndicator();
          }
          if(_controller.listEventos.status == FutureStatus.fulfilled){
            _controller.transformInEvents();
            return _body();
          }
          return Container();
        }
      ),
    );
  }

  Widget _body() => SingleChildScrollView(
    child: Column(
      children: [
        TableCalendar(
          events: _controller.calendarEvents,
          locale: 'pt_BR',
          availableGestures: AvailableGestures.horizontalSwipe,
          calendarController: _calendarController,
          startingDayOfWeek: StartingDayOfWeek.monday,
          daysOfWeekStyle: DaysOfWeekStyle(
            weekendStyle: TextStyle(color: neutralMid)
          ),
          calendarStyle: CalendarStyle(
            selectedColor: secondaryColor,
            todayColor: secondary,
            markersColor: neutralMid,
            outsideWeekendStyle: TextStyle(color: neutralMid),
            weekdayStyle: TextStyle(color: secondary),
            weekendStyle: TextStyle(color: neutralMid),
            outsideDaysVisible: true,
          ),
          onDaySelected: (DateTime _date,List _listEventos,List list){
            _controller.filterEvents(_date, _listEventos);
          },
          headerStyle: HeaderStyle(
            titleTextBuilder: (date, text) =>
              DateFormat.MMMM('pt_BR').format(date).toUpperCase(),
            formatButtonShowsNext: false,
            formatButtonVisible: false,
            centerHeaderTitle: true,
            titleTextStyle: TextStyle(color: secondary,fontSize: 18.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _ac.rWP(2),vertical: _ac.rHP(3)),
          child: Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _controller.listEventos.value.length,
              itemBuilder: (ctx,idx){
                EventosPorMesModel _listEventos = _controller.listEventos.value[idx];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${_monthFormat.format(_listEventos.mes).toUpperCase()}',
                      style: TextStyle(
                        color: secondary,
                        fontSize: 20,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(bottom: _ac.rHP(3),top: _ac.rHP(1)),
                      itemCount: _listEventos.eventos.length,
                      itemBuilder: (ctx,idx){
                        EventosPorDiaModel _evento = _listEventos.eventos[idx];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_dayFormat.format(_evento.dia).toUpperCase()}',
                              style: TextStyle(
                                color: secondary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            _evento.eventos.isNotEmpty ? ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(vertical: _ac.rHP(2),),
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _evento.eventos.length,
                              itemBuilder: (ctx,idx){
                                var _agendamento = _evento.eventos[idx];
                                return EventoCard(
                                  evento: _agendamento,
                                );
                              }
                            ): Container(
                              padding: EdgeInsets.symmetric(vertical: _ac.rHP(4)),
                              alignment: Alignment.center,
                              child: Text(
                                'Nenhum evento para este dia!',
                                style: TextStyle(
                                  color: secondary,
                                  fontSize: 20,
                                ),
                              )
                            ),
                          ],
                        );
                      }
                    )
                  ],
                );  
              }
            )
          ),
        )
      ],
    ),
  );

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    bool _result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CalendarModal(),
        ));
    if(_result != null){
      _controller.getListEventos(_user.uid);
    }
  }

}