import 'dart:io';

import 'package:escol/modules/firebase/models/firebaseUserModel.dart';
import 'package:escol/modules/shared/getItRepository.dart';
import 'package:escol/views/perfil/perfilPageController.dart';
import 'package:escol/views/shared/circularIndicator/circularIndicator.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {

  AppConfig _ac;
  final _user = locator.get<FirebaseUserModel>();
  PerfilPageController _controller;
  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    _controller = PerfilPageController(_user.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Perfil',
          style: TextStyle(
            color: secondary,
            fontSize: 20
          ),
        ),
      ),
      backgroundColor: primary,
      body: Observer(
        builder: (_){
          if(_controller.escola.status == FutureStatus.pending){
            return CircularIndicator();
          }
          if(_controller.escola.status == FutureStatus.fulfilled){
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
        SizedBox(height: _ac.rHP(2)),
        RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: Colors.white,
          child: Container(
            height: _ac.rH(23),
            decoration: BoxDecoration(
              border: Border.all(
                width: 4,
                color: secondary
              ),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/person_sample_4.jpg'),
              )
            ),
          ),
          shape: CircleBorder(),
        ),
        SizedBox(height: _ac.rHP(2)),
        _listTitle('Nome:','${toBeginningOfSentenceCase(_user.displayName)}'),
        _listTitle('Email:','${toBeginningOfSentenceCase(_user.email)}'),
        _listTitle('Telefone:','${toBeginningOfSentenceCase(_user.phoneNumber)}'),
        _listTitle('Escola:','${toBeginningOfSentenceCase(_controller.escola.value.nome)}'),
        Container(
          margin: EdgeInsets.only(top: _ac.rHP(3)),
          padding: EdgeInsets.zero,
          width: _ac.rW(90),
          height: _ac.rH(7),
          decoration: BoxDecoration(
            color: secondary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: primaryshadow,
                offset: Offset(0,4),
                blurRadius: 5.0
              )
            ]
          ),
          child: RaisedButton(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))
            ),
            color: secondaryColor,
            elevation: 0,
            onPressed: () {
              
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Tirar foto',
                    style: TextStyle(
                    fontSize: 20,
                    color: primary,
                  ),
                ),
                SizedBox(width: _ac.rW(3)),
                Icon(Icons.camera_alt_outlined,size: 20,color: primary,)
              ],
            )
          )
        ),
      ],
    ),
  );

  Widget _listTitle(String _title,String _subtitle) => ListTile(
    title: Text(
      '$_title',
      style: TextStyle(
        color: secondary,
        fontWeight: FontWeight.w800,
        fontSize: 15
      ),
    ),
    subtitle: Text(
      '$_subtitle',
      style: TextStyle(
        color: secondary,
        fontWeight: FontWeight.w400,
        fontSize: 17
      ),
    ),
  );

}