import 'package:cached_network_image/cached_network_image.dart';
import 'package:escol/modules/firebase/models/enum/typeUserEnum.dart';
import 'package:escol/modules/firebase/models/firebaseUserModel.dart';
import 'package:escol/modules/shared/getItRepository.dart';
import 'package:escol/views/pesquisa/PesquisaPageController.dart';
import 'package:escol/views/shared/circularIndicator/circularIndicator.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:shimmer/shimmer.dart';

class PesquisaPage extends StatefulWidget {
  @override
  _PesquisaPageState createState() => _PesquisaPageState();
}

class _PesquisaPageState extends State<PesquisaPage> {
  TextEditingController _textController = TextEditingController();
  PesquisaPageController _controller = PesquisaPageController();
  final _user = locator.get<FirebaseUserModel>();

  AppConfig _ac;
  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
          iconTheme: IconThemeData(color: neutralMid),
          backgroundColor: primary,
          elevation: 2,
          titleSpacing: 4,
          title: Observer(builder: (_) {
            return TextField(
              controller: _textController,
              autofocus: true,
              onChanged: (String _text) {
                _controller.setSearch(_text);
                if (_text.length != 0) {
                  _controller.searchUsers(_user.uid, _text.toLowerCase());
                }
              },
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(color: secondary, fontSize: 17),
              decoration: InputDecoration(
                  hintText: 'Pesquise!',
                  border: InputBorder.none,
                  hintStyle:
                      TextStyle(color: neutralMid, fontWeight: FontWeight.bold),
                  suffixIcon: _controller.search.length != 0
                      ? IconButton(
                          icon: Icon(
                            Icons.close_outlined,
                            color: secondary,
                            size: 25,
                          ),
                          onPressed: () {
                            _textController.clear();
                            _controller.setSearch('');
                          })
                      : Container(
                          width: 0,
                        )),
            );
          })),
      body: Observer(builder: (_) {
        if (_controller.users != null) {
          if (_controller.users.status == FutureStatus.pending) {
            return CircularIndicator();
          }
          if (_controller.users.status == FutureStatus.fulfilled) {
            return _body();
          }
        }
        return Container();
      }),
    );
  }

  Widget _body() => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: _ac.rHP(3), horizontal: _ac.rWP(3)),
          child: Column(
            children: [
              Container(
                child: Text('Filtros'),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: _controller.users.value.length,
                  itemBuilder: (ctx, idx) {
                    var _users = _controller.users.value[idx];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: _ac.rHP(2)),
                      padding: EdgeInsets.symmetric(
                          vertical: _ac.rHP(2), horizontal: _ac.rWP(2)),
                      decoration: BoxDecoration(
                          color: neutralLighter,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: '${_users.photoURL}',
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    margin: EdgeInsets.only(right: _ac.rWP(2)),
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) => Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Shimmer.fromColors(
                                      direction: ShimmerDirection.ltr,
                                      baseColor: neutralLighter,
                                      highlightColor: primary,
                                      child: Container(
                                        width: 40.0,
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${_users.displayName}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: secondary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${GetNameTypeUserEnum[TypeUserEnum.values[_users.typeUser]]}',
                                      style: TextStyle(
                                          fontSize: 16, color: secondary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      );
}
