import 'package:escol/views/shared/dialog/customDialog.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:flutter/material.dart';

class YesOrNoDialog extends StatefulWidget {

  final String title;
  final String  subTitle;
  final bool styleButtonNo;

  const YesOrNoDialog({Key key, @required this.title, @required this.subTitle, @required this.styleButtonNo}) : super(key: key);
  @override
  _YesOrNoDialogState createState() => _YesOrNoDialogState();
}

class _YesOrNoDialogState extends State<YesOrNoDialog> {

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
              title: widget.title,
              subTitle: widget.subTitle,
              buttons: <Widget>[
                styleButtomNo(style: widget.styleButtonNo),
                FlatButton(
                  color: Colors.white,
                  onPressed: () {                 
                    Navigator.pop(context, true);
                  },
                  child: Text('YES',
                    style: TextStyle(
                      color: primary,
                    )
                  ),
                ),
              ],
          );
          
  }
   

   Widget styleButtomNo({bool style}) {

     if(style) {
       return FlatButton(
            color: primary,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('NO',
              style: TextStyle(
                color: Colors.white,
              )
            ),
          );
     } else {

       return  FlatButton(
                  color: Colors.white,
                  onPressed: () {                 
                    Navigator.pop(context, false);
                  },
                  child: Text('NO',
                    style: TextStyle(
                      color: primary,
                    )
                  ),
                );
     }

     

   }

}