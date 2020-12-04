import 'package:escol/views/login/mainLoginPageController.dart';
import 'package:escol/views/login/pages/student/signin/studentPage.dart';
import 'package:escol/views/shared/circularIndicator/circularIndicator.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:escol/views/tabs/tabPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class MainLoginPage extends StatefulWidget {
  @override
  _MainLoginPageState createState() => _MainLoginPageState();
}

class _MainLoginPageState extends State<MainLoginPage> {
  final _controller = MainLoginPageController();
  AppConfig _ac;

  @override
  void initState() {
    super.initState();
    _controller.isLogged.listen(_isLogged);
  }

  void _isLogged(bool _confirm) {
    if (_confirm) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (BuildContext context) => TabPage()));
    } else {
      //TODO: mainLoginPage => fazer alerta de erro;
    }
  }

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(
      body: Observer(builder: (_) {
        if (_controller.login != null) {
          if (_controller.login.status == FutureStatus.pending) {
            return CircularIndicator();
          }
          if (_controller.login.status == FutureStatus.fulfilled) {
            return _body();
          }
          if (_controller.login.status == FutureStatus.rejected) {
            return _body();
          }
        }
        return Container();
      }),
    );
  }

  Widget _body() => Container(
      width: _ac.rW(100),
      height: _ac.rH(100),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/main_login_page_bg.jpg'),
              colorFilter: ColorFilter.mode(
                  secondaryColor.withOpacity(0.5), BlendMode.srcOver),
              fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: _ac.rH(15)),
            width: _ac.rW(75),
            height: _ac.rH(10),
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/logo_white.png')),
            ),
          ),
          Container(
            width: _ac.rW(100),
            height: _ac.rH(45),
            decoration: BoxDecoration(
                color: primary,
                boxShadow: [
                  BoxShadow(color: secondary.withOpacity(0.4), blurRadius: 5)
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _ac.rH(5),
                ),
                Text(
                  'ENTRAR',
                  style: TextStyle(
                      fontSize: 40,
                      color: secondary,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: _ac.rH(4),
                ),
                Container(
                    padding: EdgeInsets.zero,
                    width: _ac.rW(90),
                    height: _ac.rH(8),
                    decoration: BoxDecoration(
                      color: neutralLighter,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: RaisedButton(
                        focusElevation: 0,
                        highlightElevation: 0,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        color: neutralLighter,
                        elevation: 0,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      StudentPage()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Sou Aluno',
                              style: TextStyle(
                                fontSize: 20,
                                color: secondary,
                              ),
                            ),
                            SizedBox(width: _ac.rW(3)),
                            Icon(
                              Icons.arrow_forward,
                              size: 20,
                            )
                          ],
                        ))),
                Container(
                    margin: EdgeInsets.only(top: _ac.rHP(3)),
                    padding: EdgeInsets.zero,
                    width: _ac.rW(90),
                    height: _ac.rH(8),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: RaisedButton(
                        focusElevation: 0,
                        highlightElevation: 0,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        color: secondaryColor,
                        elevation: 0,
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Sou Professor',
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
          )
        ],
      ));
}
