import 'package:escol/modules/firebase/models/firebaseUserModel.dart';
import 'package:escol/modules/shared/getItRepository.dart';
import 'package:escol/views/home/homePageController.dart';
import 'package:escol/views/search/searchPage.dart';
import 'package:escol/views/profile/profilePage.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:escol/views/widgets/HomePageLoading.dart';
import 'package:escol/views/widgets/classesCard.dart';
import 'package:escol/views/widgets/cachedImageNetwork.dart';
import 'package:escol/views/widgets/subjectCard.dart';
import 'package:escol/views/widgets/postCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _user = locator.get<FirebaseUserModel>();
  HomePageController _controller;
  AppConfig _ac;

  @override
  void initState() {
    _controller = HomePageController(_user.uid);
    _controller.nameFormated(_user.displayName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(backgroundColor: primary, body: _body());
  }

  Widget _bodyContent() => Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: neutralLighter,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.symmetric(
                horizontal: _ac.rWP(3), vertical: _ac.rHP(1)),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PesquisaPage()));
              },
              child: TextField(
                enabled: false,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(color: secondary, fontSize: 17),
                decoration: InputDecoration(
                    hintText: 'Pesquise!',
                    hintStyle: TextStyle(
                        color: neutralMid, fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search_outlined,
                      color: neutralMid,
                      size: 25,
                    )),
              ),
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
                    color: neutralDarker,
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
                return SubjectCard(
                  subject: _controller.subjectLists.value[idx],
                );
              },
              itemCount: _controller.subjectLists.value.length,
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: _ac.rWP(3)),
              margin: EdgeInsets.only(top: _ac.rHP(3)),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Minhas aulas',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: neutralDarker,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    '${_controller.getDate()}',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: secondary, fontSize: 15),
                  ),
                ],
              )),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: _ac.rHP(0.5)),
            height: _ac.rH(10),
            width: _ac.rW(100),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                  vertical: _ac.rHP(1), horizontal: _ac.rWP(3)),
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, idx) {
                var _aula = _controller.classLists.value[idx];
                return ClassCard(
                  idx: idx,
                  classes: _aula,
                );
              },
              itemCount: _controller.classLists.value.length,
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
                    color: neutralDarker,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
          PostCard(news: _controller.news.value),
        ],
      );

  Widget _body() => SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    _ac.rWP(3), _ac.rHP(4), _ac.rWP(3), _ac.rHP(2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: _ac.rW(70),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_controller.getDateFormated()}',
                            style: TextStyle(
                              color: secondary,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Olá, ${_controller.nameFormated(_user.displayName)}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: neutralDarker,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: CachedImageNetwork(
                            urlImg: '${_user.photoURL}',
                            witdh: 80,
                            height: 80,
                            boxShape: BoxShape.circle,
                            childShimmer: Container(
                              decoration: BoxDecoration(shape: BoxShape.circle),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage()));
                          }),
                    )
                  ],
                ),
              ),
            ),
            Observer(builder: (_) {
              if (_controller.subjectLists.status == FutureStatus.pending ||
                  _controller.news.status == FutureStatus.pending ||
                  _controller.classLists.status == FutureStatus.pending) {
                return HomePageLoading();
              }
              if (_controller.subjectLists.status == FutureStatus.fulfilled &&
                  _controller.news.status == FutureStatus.fulfilled &&
                  _controller.classLists.status == FutureStatus.fulfilled) {
                return _bodyContent();
              }
              return Container();
            }),
          ],
        ),
      );
}
