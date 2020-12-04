import 'package:escol/modules/firebase/models/firebaseUserModel.dart';
import 'package:escol/modules/shared/getItRepository.dart';
import 'package:escol/modules/student/models/classModel.dart';
import 'package:escol/modules/student/models/scheduleModel.dart';
import 'package:escol/modules/student/models/subjectModel.dart';
import 'package:escol/views/schedule/modal/scheduleEditModalController.dart';
import 'package:escol/views/shared/circularIndicator/circularIndicator.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:escol/views/widgets/dayCard.dart';
import 'package:escol/views/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class HorarioEditModal extends StatefulWidget {
  final List<ScheduleModel> listHorarios;
  final List<SubjectModel> listMaterias;

  const HorarioEditModal(
      {Key key, @required this.listHorarios, @required this.listMaterias})
      : super(key: key);
  @override
  _HorarioEditModalState createState() => _HorarioEditModalState();
}

class _HorarioEditModalState extends State<HorarioEditModal> {
  final ScheduleEditModalController _controller = ScheduleEditModalController();
  AppConfig _ac;
  FirebaseUserModel _user = locator.get<FirebaseUserModel>();

  @override
  void initState() {
    _controller.setListHorarios(widget.listHorarios);
    _controller.setListMaterias(widget.listMaterias);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Observer(builder: (_) {
      if (_controller.isLoaded != null) {
        if (_controller.isLoaded.status == FutureStatus.pending) {
          return CircularIndicator();
        }
      }
      return Scaffold(
        backgroundColor: primary,
        body: _body(),
        bottomNavigationBar: Container(
          color: secondaryColor,
          width: _ac.rW(35),
          height: _ac.rH(8),
          child: RaisedButton(
            onPressed: () async {
              var _result = await _controller.saveHorario(
                  _user.uid, _controller.listHorarios);
              if (_result.isSuccess) {
                Navigator.of(context).pop(_controller.listHorarios);
              }
            },
            color: secondaryColor,
            elevation: 0,
            child: Text(
              'Salvar',
              style: TextStyle(
                  color: primary, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
      );
    });
  }

  Widget _body() => SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              AppBar(
                centerTitle: true,
                elevation: 0,
                title: Text(
                  'Editar Horario',
                  style: TextStyle(color: secondary, fontSize: 20),
                ),
                backgroundColor: primary,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: _ac.rHP(2)),
                height: _ac.rH(16),
                child: Observer(
                  builder: (_) {
                    var _daySelected = _controller.daySelected;
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                          horizontal: _ac.rWP(3), vertical: _ac.rHP(1)),
                      itemCount: 5,
                      itemBuilder: (ctx, idx) {
                        DateFormat _formatDate = DateFormat('d/MM');
                        DateFormat _formatDay = DateFormat('E', 'pt_Br');
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
                    var _listAulas = _controller.listHorarios[_daySelected];
                    return ExpansionPanelList(
                      elevation: 0,
                      expansionCallback: (idx, isExpanded) {
                        setState(() {
                          _listAulas.classes[idx].isExpanded =
                              !_listAulas.classes[idx].isExpanded;
                        });
                      },
                      children:
                          _listAulas.classes.mapIndex((ClassModel _aula, _idx) {
                        SubjectModel _materiaCompleta =
                            _controller.getMateriaCompleta(_aula);
                        return ExpansionPanel(
                            canTapOnHeader: true,
                            headerBuilder: (ctx, isExpanded) {
                              return ListTile(
                                title: Text(
                                  '${toBeginningOfSentenceCase(_materiaCompleta.name)}',
                                  style: TextStyle(
                                      color: secondary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                subtitle: Text('${_idx + 1}º Aula'),
                              );
                            },
                            isExpanded: _aula.isExpanded,
                            body: Container(
                              color: primary,
                              padding: EdgeInsets.symmetric(
                                horizontal: _ac.rWP(3),
                              ),
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _controller.listMaterias.length,
                                  itemBuilder: (ctx, idx) {
                                    var _materia =
                                        _controller.listMaterias[idx];
                                    return ListTile(
                                      onTap: () {
                                        _controller.changeHorario(
                                            _materia.name, _idx);
                                      },
                                      title: Text(
                                        '${toBeginningOfSentenceCase(_materia.name)}',
                                        style: TextStyle(
                                            color: secondary,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20),
                                      ),
                                      subtitle: Text(
                                        '${toBeginningOfSentenceCase(_materia.teacher)}',
                                        style: TextStyle(
                                            color: secondary,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 15),
                                      ),
                                    );
                                  }),
                            ));
                      }).toList(),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
}
