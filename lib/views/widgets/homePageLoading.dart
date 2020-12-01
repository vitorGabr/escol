import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomePageLoading extends StatefulWidget {
  @override
  _HomePageLoadingState createState() => _HomePageLoadingState();
}

class _HomePageLoadingState extends State<HomePageLoading> {
  AppConfig _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: neutralLighter,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.symmetric(
                horizontal: _ac.rWP(3), vertical: _ac.rHP(1)),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              enabled: false,
              style: TextStyle(color: secondary, fontSize: 15),
              decoration: InputDecoration(
                  hintText: 'Pesquise!',
                  hintStyle:
                      TextStyle(color: neutralMid, fontWeight: FontWeight.bold),
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: neutralMid,
                    size: 25,
                  )),
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: _ac.rWP(3)),
              margin: EdgeInsets.only(top: _ac.rHP(3)),
              alignment: Alignment.centerLeft,
              child: Text(
                'Minhas matérias',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
          Container(
            margin: EdgeInsets.symmetric(vertical: _ac.rHP(0.3)),
            height: _ac.rH(16),
            width: _ac.rW(100),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                  vertical: _ac.rHP(1), horizontal: _ac.rWP(3)),
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, idx) {
                return materiaLoading();
              },
              itemCount: 5,
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: _ac.rWP(3)),
              margin: EdgeInsets.only(top: _ac.rHP(3)),
              alignment: Alignment.centerLeft,
              child: Text(
                'Minhas aulas',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: _ac.rHP(0.3)),
            height: _ac.rH(10),
            width: _ac.rW(100),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                  vertical: _ac.rHP(1), horizontal: _ac.rWP(3)),
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, idx) {
                return aulaLoading(idx);
              },
              itemCount: 5,
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: _ac.rWP(3)),
              margin: EdgeInsets.only(top: _ac.rHP(3)),
              alignment: Alignment.centerLeft,
              child: Text(
                'Último Post',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
          ultimoPostLoading()
        ],
      ),
    );
  }

  Widget materiaLoading() => Container(
        width: _ac.rW(20),
        margin: EdgeInsets.only(right: _ac.rWP(3)),
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

  Widget aulaLoading(int _idx) => Container(
        width: _ac.rW(14),
        height: _ac.rW(10),
        margin: EdgeInsets.only(right: _idx != 4 ? _ac.rWP(5.5) : 0),
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

  Widget ultimoPostLoading() => Container(
        height: _ac.rH(25),
        width: _ac.rH(100),
        margin: EdgeInsets.symmetric(
            vertical: _ac.rHP(1.03), horizontal: _ac.rWP(3)),
        child: Shimmer.fromColors(
          direction: ShimmerDirection.ltr,
          baseColor: neutralLighter,
          highlightColor: neutralPrimary,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: primary,
            ),
          ),
        ),
      );
}
