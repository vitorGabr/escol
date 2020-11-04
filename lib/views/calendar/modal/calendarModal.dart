import 'package:escol/modules/aluno/models/eventModel/eventoModel.dart';
import 'package:escol/modules/aluno/models/materiaModel.dart';
import 'package:escol/modules/aluno/models/salaModel.dart';
import 'package:escol/modules/firebase/models/firebaseUserModel.dart';
import 'package:escol/modules/shared/getItRepository.dart';
import 'package:escol/views/calendar/modal/calendarModalController.dart';
import 'package:escol/views/shared/circularIndicator/circularIndicator.dart';
import 'package:escol/views/shared/dialog/successDialog.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

class CalendarModal extends StatefulWidget {
  @override
  _CalendarModalState createState() => _CalendarModalState();
}

class _CalendarModalState extends State<CalendarModal> {

  DateFormat _formatDate = DateFormat('d/MM/y');
  final _user = locator.get<FirebaseUserModel>();
  CalendarModalController _controller;
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  AppConfig _ac;
  String dropdownValue = 'One';

  @override
  void initState() {
    _controller = CalendarModalController(_user.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: secondary
        ),
        elevation: 0,
        title: Text(
          'Criar Evento',
          style: TextStyle(
            color: secondary,
            fontSize: 20
          ),
        ),
        backgroundColor: primary,
      ),
      bottomNavigationBar:Container(
        color: secondaryColor,
        width: _ac.rW(35),
        height: _ac.rH(8),
        child: RaisedButton(
          onPressed: () async {
            if(_controller.isValidated(
              _tituloController.text,
              _descricaoController.text
            )){
              var _date = _controller.selectedDate
                .add(
                  Duration(
                    hours: _controller.selectedTime.hour,
                    minutes: _controller.selectedTime.minute
                  )
                );
              EventoModel _evento = EventoModel()
                ..titulo = _tituloController.text
                ..descricao = _descricaoController.text
                ..data = _date
                ..materia = _controller.dropdown;

              var _result = await _controller.saveEvento(_user.uid, _evento);
              if(_result.isSuccess){
                  Navigator.of(context).pop(_result.isSuccess);
                }
            }else{
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SuccessDialog(
                    title: "Atenção!", 
                    subTitle: "Prencha os campos restantes!!", 
                    icone: Icons.error,
                  );
              });
            }
          },
          color: secondaryColor,
          elevation: 0,
          child:Text(
            'Criar',
            style: TextStyle(
              color: primary,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ), 
        ),
      ), 
      backgroundColor: primary,
      body: Observer(
        builder: (_){
          if(_controller.sala.status == FutureStatus.pending ||
              _controller.materias.status == FutureStatus.pending){
            return CircularIndicator();
          }
          if(_controller.sala.status == FutureStatus.fulfilled &&
              _controller.materias.status == FutureStatus.fulfilled){
            return _body();
          }
          if(_controller.isLoaded != null){
            if(_controller.isLoaded.status == FutureStatus.pending){
              return CircularIndicator();
            }
          }
          return Container();
        },
      ),
    );
  }
  
  Widget _body() => SingleChildScrollView(
    child: Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: _ac.rHP(2),horizontal: _ac.rWP(3)),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: _ac.rH(7),
              decoration: BoxDecoration(
                color: neutralLighter,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: primaryshadow,
                    offset: Offset(0,4),
                    blurRadius: 5.0
                  )
                ],
              ),
              child: TextFormField(
                controller: _tituloController,
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  color: secondary,
                  fontSize: 16
                ),
                decoration: InputDecoration(
                  hintText: 'Crie um título',
                  hintStyle: TextStyle(
                    color: secondary,
                    fontSize: 16
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: _ac.rHP(2),horizontal: _ac.rWP(3))
                ),
              ),
            ),
            SizedBox(height: _ac.rH(3),),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Escolha uma data',
                        style: TextStyle(
                          color: secondary,
                          fontSize: 16
                        ),
                      ),
                      SizedBox(
                        height: _ac.rHP(1),
                      ),
                      Observer(
                        builder: (_){
                          return Container(
                            width: _ac.rW(45),
                            height: _ac.rH(7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryshadow,
                                  offset: Offset(0,4),
                                  blurRadius: 5.0
                                )
                              ],
                            ),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                              color: secondary,
                              onPressed: (){
                                _selectDate(context);
                              },
                              child: Text(
                                _controller.selectedDate != null ? 
                                  '${_formatDate.format(_controller.selectedDate)}' :
                                  'Ex ${_formatDate.format(DateTime.now())}',
                                style: TextStyle(
                                  color: primary,
                                  fontSize: 16
                                ),
                              ),
                            ),
                          );
                        }
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Escolha um horario',
                        style: TextStyle(
                          color: secondary,
                          fontSize: 16
                        ),
                      ),
                      SizedBox(
                        height: _ac.rHP(1),
                      ),
                      Observer(
                        builder: (_){
                          return Container(
                            width: _ac.rW(45),
                            height: _ac.rH(7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryshadow,
                                  offset: Offset(0,4),
                                  blurRadius: 5.0
                                )
                              ],
                            ),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                              ),
                              elevation: 0,
                              color: secondary,
                              onPressed: (){
                                _selectTime(context);
                              },
                              child: Text(
                                _controller.selectedTime != null ?
                                  '${_controller.selectedTime.format(context)}' :
                                  'Ex: 19:30',
                                style: TextStyle(
                                  color: primary,
                                  fontSize: 16
                                ),
                              ),
                            ),
                          );
                        }
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: _ac.rH(3),),
            Container(
              alignment: Alignment.center,
              height: _ac.rH(7),
              decoration: BoxDecoration(
                color: neutralLighter,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: primaryshadow,
                    offset: Offset(0,4),
                    blurRadius: 5.0
                  )
                ],
              ),
              child: Observer(
                builder: (_){
                  return _dropdown();
                }
              )
            ),
            SizedBox(height: _ac.rH(3),),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: neutralLighter,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: primaryshadow,
                    offset: Offset(0,4),
                    blurRadius: 5.0
                  )
                ],
              ),
              child: TextFormField(
                maxLines: 15,
                controller: _descricaoController,
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  color: secondary,
                  fontSize: 16
                ),
                decoration: InputDecoration(
                  hintText: 'Coloque a descição do evento...',
                  hintStyle: TextStyle(
                    color: secondary,
                    fontSize: 16
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: _ac.rHP(2),horizontal: _ac.rWP(3))
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: secondaryColor,
                accentColor: secondaryColor,
                colorScheme: ColorScheme.light(primary: secondaryColor),
                buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary
                ),
            ),
            child: child,
          );
        },
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year+2));
    if (picked != null && picked != _controller.selectedDate){
      _controller.changePicked(picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: secondaryColor,
                accentColor: secondaryColor,
                colorScheme: ColorScheme.light(primary: secondaryColor),
                buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary
                ),
            ),
            child: child,
          );
        },
      );
    if (picked != null && picked != _controller.selectedTime){
      _controller.changeTimePicked(picked);
    }
  }

  Widget _dropdown() => DropdownButton<String>(
      value: _controller.dropdown,
      icon: Icon(Icons.arrow_downward,color: secondary,size: 20,),
      iconSize: 24,
      elevation: 16,
      dropdownColor: neutralLighter,
      style: TextStyle(color: secondary),
      underline: Container(
        height: 0,
        color: secondary,
      ),
      onChanged: (String _newValue) {
        _controller.changeDropdown(_newValue);
      },
      items: _controller.materias.value.map<DropdownMenuItem<String>>((MateriaModel value) {
        return DropdownMenuItem<String>(
          value: value.nome,
          child: Container(
            width: _ac.rW(80),
            child: Text(
              value.nome,
              style: TextStyle(
                color: secondary,
                fontSize: 16
              ),
            )
          ),
        );
      }).toList(),
    );

}