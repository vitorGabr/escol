import 'package:escol/modules/firebase/models/firebaseUserModel.dart';
import 'package:escol/modules/shared/getItRepository.dart';
import 'package:escol/views/noticias/noticiasPage.dart';
import 'package:escol/views/perfil/perfilPage.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:flutter/material.dart';

class MoreOptionPage extends StatefulWidget {
  @override
  _MoreOptionPageState createState() => _MoreOptionPageState();
}

class _MoreOptionPageState extends State<MoreOptionPage> {
  AppConfig _ac;
  final FirebaseUserModel _user = locator.get<FirebaseUserModel>();
  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primary,
        centerTitle: true,
        title: Text('Mais')
      ),
      body: _body(),
    );
  }
  Widget _body() => SingleChildScrollView(
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _ac.rWP(3),vertical: _ac.rHP(1)),
          child: RaisedButton(
            color: primary,
            highlightColor: neutralLighter,
            highlightElevation: 0,
            splashColor: neutralLighter,
            elevation: 0,
            padding: EdgeInsets.zero,
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PerfilPage()
              ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: _ac.rH(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/person_sample_4.jpg'),
                        )
                      ),
                    ),
                    SizedBox(width: _ac.rWP(2),),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_user.displayName}',
                          style: TextStyle(
                            color: neutralDarker,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        ),
                        Text(
                          '${_user.email}',
                          style: TextStyle(
                            fontSize: 13,
                            color: secondary
                          ),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ), 
                  ],
                ),
                Icon(Icons.keyboard_arrow_right,color: secondary,)
              ],
            ),
          ),
        ),
        Divider(color: neutralDarker),
        SizedBox(height: _ac.rHP(2),),
        _menuItem(Icons.notes_outlined,'Boletim'),
        _menuItem(Icons.check,'Presença'),
        _menuItem(Icons.search_outlined,'Pesquise pelo seu professor'),
        _menuItem(Icons.public_outlined,'Noticias'),
        _menuItem(Icons.book_outlined,'Biblioteca'),
        _menuItem(Icons.restaurant_outlined,'Cantina'),
      ],
    ),
  );

  Widget _menuItem(IconData _icon,String _text) => Container(
    child: RaisedButton(
      color: primary,
      highlightColor: neutralLighter,
      highlightElevation: 0,
      splashColor: neutralLighter,
      elevation: 0,
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoticiasPage()
        ));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: _ac.rHP(2)),
        child: Row(
          children: [
            Icon(_icon,color: secondary,size: 18,),
            SizedBox(width: _ac.rWP(2),),
            Text(
              '$_text',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: secondary
              ),
            )
          ],
        ),
      ),
    ),
  );

}