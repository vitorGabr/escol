import 'package:escol/modules/firebase/models/firebaseUserModel.dart';
import 'package:escol/modules/noticias/models/enum/categoriaEnum.dart';
import 'package:escol/modules/noticias/models/noticiaModel.dart';
import 'package:escol/modules/shared/getItRepository.dart';
import 'package:escol/views/noticias/noticiasPageController.dart';
import 'package:escol/views/shared/circularIndicator/circularIndicator.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:escol/views/widgets/ultimoPostCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class NoticiasPage extends StatefulWidget {
  @override
  _NoticiasPageState createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {

  final FirebaseUserModel _user = locator.get<FirebaseUserModel>();
  NoticiasPageController _controller;
  AppConfig _ac;

  @override
  void initState() {
    _controller = NoticiasPageController(_user.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primary,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.search_outlined),
          )
        ],
        title: Text('Noticias'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: (){
        },
        tooltip: 'Increment',
        child: new Icon(Icons.edit_outlined,color: primary,),
        elevation: 4.0,
      ),
      body: Observer(
        builder: (_){
          if(_controller.listNoticias.status == FutureStatus.pending){
            return CircularIndicator();
          }
          if(_controller.listNoticias.status == FutureStatus.fulfilled){

            return _body();
          }
          return Container();
        }
      ),
    );
  }

  Widget _body() => SingleChildScrollView(
    child: Column(
      children: [
        Container(
          width: _ac.rW(100),
          height: _ac.rH(5),
          child: Observer(
            builder: (_){
              var _categoria = _controller.categoria;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: GetNameCategoriaEnum.length,
                padding: EdgeInsets.symmetric(horizontal: _ac.rWP(3)),
                itemBuilder: (ctx,idx){
                  return Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: _ac.rHP(1)),
                    child: InkWell(
                      onTap: (){
                        _controller.setCategoria(idx);
                      },
                      highlightColor: neutralLighter,
                      splashColor: neutralLighter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: _ac.rWP(2)),
                        child: Text(
                          '${GetNameCategoriaEnum.values.toList()[idx]}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: idx == _categoria ? 23 : 15,
                            fontWeight:  idx == _categoria ? FontWeight.bold : FontWeight.normal
                          ),
                        ),
                      ),
                    ),
                  );
                }, 
              );
            },
          )
        ),
        Observer(
          builder: (_){
            var _categoria = _controller.categoria;
            List<NoticiaModel> _list = _controller.filteredNoticias(_categoria);
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _list.length,
              itemBuilder: (ctx,idx){
                return UltimoPostCard(
                  noticia: _list[idx],
                );
              },
            );
          }
        )
      ],
    ),
  );

}