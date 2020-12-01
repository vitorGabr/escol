import 'dart:io';

import 'package:escol/modules/firebase/models/firebaseUserModel.dart';
import 'package:escol/modules/shared/getItRepository.dart';
import 'package:escol/views/perfil/perfilPageController.dart';
import 'package:escol/views/shared/circularIndicator/circularIndicator.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:escol/views/widgets/cachedImageNetwork.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
          style: TextStyle(color: secondary, fontSize: 20),
        ),
      ),
      backgroundColor: primary,
      body: Observer(builder: (_) {
        if (_controller.escola.status == FutureStatus.pending) {
          return CircularIndicator();
        }
        if (_controller.escola.status == FutureStatus.fulfilled) {
          return _body();
        }
        return Container();
      }),
    );
  }

  Widget _body() => SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: _ac.rHP(2)),
            CachedImageNetwork(
              urlImg: '${_user.photoURL}',
              witdh: _ac.rW(45),
              height: _ac.rW(45),
              boxShape: BoxShape.circle,
              childShimmer: Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
              ),
            ),
            SizedBox(height: _ac.rHP(4)),
            _listTitle(
                'Nome:', '${toBeginningOfSentenceCase(_user.displayName)}'),
            _listTitle('Email:', '${toBeginningOfSentenceCase(_user.email)}'),
            _listTitle(
                'Telefone:', '${toBeginningOfSentenceCase(_user.phoneNumber)}'),
            _listTitle('Escola:',
                '${toBeginningOfSentenceCase(_controller.escola.value.nome)}'),
          ],
        ),
      );

  Widget _listTitle(String _title, String _subtitle) => ListTile(
        title: Text(
          '$_title',
          style: TextStyle(
              color: neutralDarker, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        subtitle: Text(
          '$_subtitle',
          style: TextStyle(color: secondary, fontSize: 17),
        ),
      );
}
