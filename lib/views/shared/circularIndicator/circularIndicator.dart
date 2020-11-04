import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {

  final Color backgroudColor;

  const CircularIndicator({Key key, this.backgroudColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroudColor != null ? backgroudColor : primary,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(secondaryColor),
        ),
      ),
    );
  }
}