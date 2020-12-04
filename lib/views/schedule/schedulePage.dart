import 'package:escol/modules/student/models/scheduleModel.dart';
import 'package:escol/modules/student/models/subjectModel.dart';
import 'package:escol/modules/firebase/models/firebaseUserModel.dart';
import 'package:escol/modules/shared/getItRepository.dart';
import 'package:escol/views/schedule/modal/scheduleEditModal.dart';
import 'package:escol/views/schedule/schedulePageController.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:escol/views/widgets/dayCard.dart';
import 'package:escol/views/widgets/scheduleCard.dart';
import 'package:escol/views/widgets/horarioPageLoading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

import '../shared/general/theme/colors.dart';

class HorarioPage extends StatefulWidget {
  @override
  _HorarioPageState createState() => _HorarioPageState();
}

class _HorarioPageState extends State<HorarioPage> {
  final _user = locator.get<FirebaseUserModel>();
  SchedulePageController _controller;

  AppConfig _ac;

  @override
  void initState() {
    _controller = SchedulePageController(_user.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButton: FloatingActionButton(
          backgroundColor: secondaryColor,
          onPressed: () {
            _awaitReturnValueFromSecondScreen(context);
          },
          tooltip: 'Increment',
          child: new Icon(
            Icons.edit_outlined,
            color: primary,
          ),
          elevation: 4.0,
        ),
        backgroundColor: primary,
        body: _body());
  }

  Widget _body() => SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              AppBar(
                centerTitle: true,
                elevation: 0,
                title: Text(
                  'Horario',
                  style: TextStyle(color: secondary, fontSize: 20),
                ),
                backgroundColor: primary,
              ),
              Observer(builder: (_) {
                if (_controller.listHorario.status == FutureStatus.pending ||
                    _controller.listMaterias.status == FutureStatus.pending) {
                  return Container(
                    child: HorarioPageLoading(),
                  );
                }
                if (_controller.listHorario.status == FutureStatus.fulfilled &&
                    _controller.listMaterias.status == FutureStatus.fulfilled) {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: _ac.rHP(2)),
                        height: _ac.rH(18),
                        child: Observer(
                          builder: (_) {
                            var _daySelected = _controller.daySelected;
                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(
                                  horizontal: _ac.rWP(3), vertical: _ac.rHP(2)),
                              itemCount: 5,
                              itemBuilder: (ctx, idx) {
                                DateFormat _formatDate = DateFormat('d/MM');
                                DateFormat _formatDay =
                                    DateFormat('E', 'pt_Br');
                                var _dateFormat = _controller.getMonday(idx);
                                var _isSelected = false;
                                if (_daySelected == idx) {
                                  _isSelected = true;
                                }
                                return DayCard(
                                  day: _formatDay.format(_dateFormat),
                                  date: _formatDate.format(_dateFormat),
                                  isSelected: _isSelected,
                                  callback: () {
                                    _controller.changeDaySelected(idx);
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Observer(
                          builder: (_) {
                            var _daySelected = _controller.daySelected;
                            return ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(
                                    vertical: _ac.rHP(2),
                                    horizontal: _ac.rWP(4)),
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _controller.listHorario.value.length,
                                itemBuilder: (ctx, idx) {
                                  var _aula = _controller.listHorario
                                      .value[_daySelected].classes[idx];
                                  SubjectModel _materiaCompleta = _controller
                                      .listMaterias.value
                                      .where((materia) =>
                                          materia.shortName == _aula.subject)
                                      .first;
                                  return ScheduleCard(
                                    idx: idx + 1,
                                    subject: _aula.subject,
                                    teacher: _aula.subject,
                                    listSubject: _controller.listMaterias.value,
                                    completeSubject: _materiaCompleta,
                                  );
                                });
                          },
                        ),
                      )
                    ],
                  );
                }
                return Container();
              }),
            ],
          ),
        ),
      );

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    List<ScheduleModel> _result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HorarioEditModal(
              listHorarios: _controller.listHorario.value,
              listMaterias: _controller.listMaterias.value),
        ));
    if (_result != null) {
      _controller.setListHorarios(_result);
    }
  }
}
