import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final String title;
  final String subTitle;
  final List<Widget> buttons;
  const CustomDialog(
      {Key key,
      @required this.title,
      @required this.subTitle,
      @required this.buttons})
      : super(key: key);

  @override
  State createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  AppConfig _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return AlertDialog(
      elevation: 4,
      title: Text(widget.title),
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: _ac.rH(1.2)),
              Text(widget.subTitle),
            ],
          ),
        ),
      ),
      actions: widget.buttons
    );
  }
}