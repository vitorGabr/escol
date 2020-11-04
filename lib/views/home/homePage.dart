import 'package:escol/modules/firebase/models/firebaseUserModel.dart';
import 'package:escol/modules/shared/getItRepository.dart';
import 'package:escol/views/configuracao/configuracaoPage.dart';
import 'package:escol/views/home/homePageController.dart';
import 'package:escol/views/perfil/perfilPage.dart';
import 'package:escol/views/shared/circularIndicator/circularIndicator.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:escol/views/widgets/HomePageLoading.dart';
import 'package:escol/views/widgets/aulasCard.dart';
import 'package:escol/views/widgets/materiaCard.dart';
import 'package:escol/views/widgets/ultimoPostCard.dart';
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
  ScrollController _scrollController = ScrollController();
  bool lastStatus = true;

  _scrollListener() {
    if (isScrollable != lastStatus) {
      setState(() {
        lastStatus = isScrollable;
      });
    }
  }

  bool get isScrollable {
    return _scrollController.hasClients && _scrollController.offset > (60 - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    _controller = HomePageController(_user.uid);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        centerTitle: true,
        elevation: isScrollable ? 3 :0,
        shadowColor: secondary.withOpacity(0.5),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: IconButton(
                padding: EdgeInsets.symmetric(vertical: _ac.rHP(0.8)),
                icon: Icon(Icons.settings_outlined,size: 25,color: secondaryColor,), 
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfiguracaoPage()
                  ));
                }
              ),
            ),
            Text(
              'Início',
              style: TextStyle(
                color: secondary,
                fontSize: 20
              ),
            ),
            Container(
              child: IconButton(
                padding: EdgeInsets.symmetric(vertical: _ac.rHP(0.8)),
                icon: Container(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/person_sample_4.jpg'),
                  ),
                ), 
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PerfilPage()
                  ));
                }
              ),
            )
          ],
        ),
        backgroundColor: primary,
      ),
      body: Observer(
        builder: (_){
          if(_controller.listMaterias.status == FutureStatus.pending ||
            _controller.noticia.status == FutureStatus.pending  ||
            _controller.listAulas.status == FutureStatus.pending  
          ){
            return HomePageLoading();
          }
          if(_controller.listMaterias.status == FutureStatus.fulfilled &&
            _controller.noticia.status == FutureStatus.fulfilled &&
            _controller.listAulas.status == FutureStatus.fulfilled
          ){
            return _body();
          }
          return Container();
        }
      ),
    );
  }

  Widget _body() => SingleChildScrollView(
    controller: _scrollController,
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: neutralLighter,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: primaryshadow,
                offset: Offset(0,4),
                blurRadius: 5.0
              )
            ]
          ),
          margin: EdgeInsets.symmetric(horizontal: _ac.rWP(3),vertical: _ac.rHP(1)),
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            obscureText: true,
            style: TextStyle(
              color: secondary,
              fontSize: 15
            ),
            decoration: InputDecoration(
              hintText: 'Pesquise seu professor!',
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search_outlined,
                color: secondary,
                size: 25,
              )
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
              color: secondary,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          )
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: _ac.rHP(0.3)),
          height: _ac.rH(16),
          width: _ac.rW(100),
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: _ac.rHP(1),horizontal: _ac.rWP(3)),
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx,idx){
              return MateriaCard(materia: _controller.listMaterias.value[idx],);
            },
            itemCount: _controller.listMaterias.value.length,
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
              fontSize: 20
            ),
          )
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: _ac.rHP(0.3)),
          height: _ac.rH(10),
          width: _ac.rW(100),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: _ac.rHP(1),horizontal: _ac.rWP(3)),
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx,idx){
              var _aula = _controller.listAulas.value[idx];
              return AulasCard(idx: idx,aula: _aula,);
            },
            itemCount: _controller.listAulas.value.length,
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
              fontSize: 20
            ),
          )
        ),
        UltimoPostCard(
          noticia:_controller.noticia.value
        ),
      ],
    ),
  );
}