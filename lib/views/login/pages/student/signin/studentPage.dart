import 'package:escol/views/login/pages/student/signin/studentPageContoller.dart';
import 'package:escol/views/shared/circularIndicator/circularIndicator.dart';
import 'package:escol/views/shared/dialog/successDialog.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:escol/views/tabs/tabPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  StudentPageController _controller = StudentPageController();
  final _formKey = GlobalKey<FormState>();
  final _textEditingEmail = TextEditingController();
  final _textEditingPass = TextEditingController();
  AppConfig _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(
      backgroundColor: primary,
      appBar: PreferredSize(
        preferredSize: Size(0, 0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
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
        return _body();
      }),
    );
  }

  Widget _body() => Form(
        key: _formKey,
        child: SafeArea(
          child: Container(
            height: _ac.rH(100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: _ac.rW(100),
                  height: _ac.rH(8),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/logo_green.png')),
                  ),
                ),
                SizedBox(
                  height: _ac.rH(8),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: _ac.rWP(5)),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        fontSize: 50,
                        color: secondary,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: _ac.rH(2),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: _ac.rWP(5)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: _ac.rH(8),
                        decoration: BoxDecoration(
                          color: neutralLighter,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextFormField(
                          controller: _textEditingEmail,
                          keyboardType: TextInputType.emailAddress,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(color: secondary, fontSize: 15),
                          decoration: InputDecoration(
                              hintText: 'Digite seu email',
                              hintStyle: TextStyle(fontWeight: FontWeight.bold),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: secondary,
                                size: 22,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: _ac.rH(3),
                      ),
                      Container(
                          alignment: Alignment.center,
                          height: _ac.rH(8),
                          decoration: BoxDecoration(
                            color: neutralLighter,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Observer(
                            builder: (_) {
                              return TextFormField(
                                controller: _textEditingPass,
                                textAlignVertical: TextAlignVertical.center,
                                style:
                                    TextStyle(color: secondary, fontSize: 15),
                                obscureText: _controller.isVisibility,
                                decoration: InputDecoration(
                                    hintText: 'Digite sua senha',
                                    hintStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.lock_outlined,
                                      color: secondary,
                                      size: 22,
                                    ),
                                    suffixIcon: RawMaterialButton(
                                      elevation: 0,
                                      constraints: BoxConstraints.tightFor(
                                        width: 35.0,
                                        height: 35.0,
                                      ),
                                      shape: CircleBorder(),
                                      onPressed: () {
                                        _controller.setVisibility(false);
                                      },
                                      child: Icon(
                                        _controller.isVisibility
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: secondary,
                                      ),
                                    )),
                              );
                            },
                          )),
                      SizedBox(
                        height: _ac.rH(3),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RaisedButton(
                            color: primary,
                            padding: EdgeInsets.zero,
                            splashColor: primary,
                            highlightColor: primary,
                            highlightElevation: 0,
                            elevation: 0,
                            onPressed: () {},
                            child: Text(
                              'Esqueci minha senha!',
                              style: TextStyle(color: neutralMid),
                            ),
                          ),
                          Container(
                              width: _ac.rW(35),
                              height: _ac.rH(6),
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
                                onPressed: () async {
                                  _controller
                                      .signInWithEmailAndPassword(
                                          _textEditingEmail.text,
                                          _textEditingPass.text)
                                      .then((_result) {
                                    if (_result.isSuccess) {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TabPage()),
                                        (Route<dynamic> route) => false,
                                      );
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SuccessDialog(
                                              title: "Atenção!",
                                              subTitle:
                                                  "Email ou Senha incorreto.",
                                              icone: Icons.error,
                                            );
                                          });
                                    }
                                  });
                                },
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                color: secondaryColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'ENTRAR',
                                      style: TextStyle(
                                        fontSize: 15,
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
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
