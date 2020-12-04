import 'package:escol/views/configuration/configurationPageController.dart';
import 'package:escol/views/login/mainLoginPage.dart';
import 'package:escol/views/shared/circularIndicator/circularIndicator.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class ConfigurationPage extends StatefulWidget {
  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  AppConfig _ac;
  final _controller = ConfigurationPageController();
  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primary,
        centerTitle: true,
        title: Text('Configuração'),
      ),
      body: Observer(builder: (_) {
        if (_controller.didLogout != null) {
          if (_controller.didLogout.status == FutureStatus.pending) {
            return CircularIndicator();
          }
          if (_controller.didLogout.status == FutureStatus.fulfilled) {
            return CircularIndicator();
          }
          if (_controller.didLogout.status == FutureStatus.rejected) {
            return _body();
          }
        }
        return _body();
      }),
    );
  }

  Widget _body() => SingleChildScrollView(
        child: Container(
          width: _ac.rW(100),
          height: _ac.rH(80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.only(top: _ac.rHP(3)),
                  padding: EdgeInsets.zero,
                  width: _ac.rW(90),
                  height: _ac.rH(7),
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: primaryshadow,
                            offset: Offset(0, 4),
                            blurRadius: 5.0)
                      ]),
                  child: RaisedButton(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      color: secondaryColor,
                      elevation: 0,
                      onPressed: () async {
                        var _result = await _controller.logout();
                        if (_result) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainLoginPage()),
                            (Route<dynamic> route) => false,
                          );
                        } else {
                          //TODO: configurationPage => Fazer alerta de erro
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Sair da conta',
                            style: TextStyle(
                              fontSize: 20,
                              color: primary,
                            ),
                          ),
                          SizedBox(width: _ac.rW(3)),
                          Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: primary,
                          )
                        ],
                      )))
            ],
          ),
        ),
      );
}
