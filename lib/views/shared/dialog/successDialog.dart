import 'dart:ui';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:flutter/material.dart';


class SuccessDialog extends StatefulWidget {

  final String title;
  final String subTitle;
  final IconData icone;
  final Function callback;
  const SuccessDialog({Key key, @required  this.title, @required this.subTitle, @required this.icone, this.callback }) : super(key: key); 

  @override
  State createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog> {
  AppConfig _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return AlertDialog(
      elevation: 4,
      title: Icon(widget.icone,
        size: 96,
        color: secondary,
      ),
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(widget.title,
                style: TextStyle(
                  fontSize: 20,
                  color: secondary,
                  fontWeight: FontWeight.bold,
                )
              ),
              SizedBox(height: _ac.rH(1.2)),
              Text(widget.subTitle),
              SizedBox(height: _ac.rH(4)),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      color: primary,
                      child: Text("Ok",
                        style: TextStyle(
                          fontSize: 16,
                          color: secondary,
                        )
                      ),
                      onPressed: (){
                        _dismissDialog();
                        if (widget.callback != null) {
                          widget.callback();
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _dismissDialog() {
    Navigator.pop(context);
  }
}