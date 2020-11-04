import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HorarioPageLoading extends StatefulWidget {
  @override
  _HorarioPageLoadingState createState() => _HorarioPageLoadingState();
}

class _HorarioPageLoadingState extends State<HorarioPageLoading> {
  AppConfig _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: _ac.rHP(2)),
            height: _ac.rH(18),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: _ac.rWP(3),vertical: _ac.rHP(2)),
              itemCount: 5,
              itemBuilder: (ctx,idx){
                return diaLoading();
              },
            )
          ),
          Container(
            alignment: Alignment.center,
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: _ac.rHP(2),horizontal: _ac.rWP(4)),
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (ctx,idx){
                return horarioLoading();
              }
            )
          )
        ],
      ),
    );
  }

  Widget diaLoading() => Container(
    margin: EdgeInsets.only(right: _ac.rWP(5)),
    width: _ac.rW(21),
    decoration: BoxDecoration(
      color: neutralLighter,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: neutralLighter,
      highlightColor: neutralPrimary,
      child: Container(
        decoration: BoxDecoration(
          color: neutralLighter,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );

  Widget horarioLoading() => Container(
    margin: EdgeInsets.symmetric(vertical: _ac.rHP(1)),
    height: _ac.rH(9),
    decoration: BoxDecoration(
      color: neutralLighter,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: neutralLighter,
      highlightColor: neutralPrimary,
      child: Container(
        decoration: BoxDecoration(
          color: neutralLighter,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );

}