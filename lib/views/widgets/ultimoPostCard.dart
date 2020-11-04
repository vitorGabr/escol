import 'package:cached_network_image/cached_network_image.dart';
import 'package:escol/modules/noticias/models/noticiaModel.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:escol/views/shared/general/theme/vars.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class UltimoPostCard extends StatelessWidget {

  final NoticiaModel noticia;

  const UltimoPostCard({Key key, 
    @required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _dateFormat = DateFormat('dd/MM/yyyy');
    AppConfig _ac = AppConfig(context);
    return Container(
      width: _ac.rH(100),
      margin: EdgeInsets.symmetric(vertical: _ac.rHP(2),horizontal: _ac.rWP(3)),
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
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: _ac.rHP(1.5),horizontal: _ac.rWP(3)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: _ac.rHP(1)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: '${noticia.usuarioImage}',
                      imageBuilder: (context, imageProvider) => Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
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
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    SizedBox(width: _ac.rWP(2)),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${noticia.usuarioNome}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: secondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 17
                            ),
                          ),
                          Text(
                            '${_dateFormat.format(noticia.data)}',
                            style: TextStyle(
                              color: secondary,
                              fontSize: 13,
                              fontWeight: FontWeight.w300
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: _ac.rHP(1)),
              child: CachedNetworkImage(
                placeholder: (context, url) => Container(
                  height: _ac.rH(25),
                  margin: EdgeInsets.symmetric(vertical: _ac.rHP(1.03),horizontal: _ac.rWP(3)),
                  child: Shimmer.fromColors(
                    direction: ShimmerDirection.ltr,
                    baseColor: neutralLighter,
                    highlightColor: primary,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primary,
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageUrl: '${noticia.imagem}'
              )
            ),
            noticia.descricao != '' ? SizedBox(height: _ac.rHP(2)) : Container(),
            noticia.descricao != null ? Text(
              '${noticia.descricao}',
              style: TextStyle(
                color: secondary,
                fontSize: 17
              ),
            ): Container(),
            SizedBox(height: _ac.rHP(0.5)),
          ],
        ),
      ),
    );
  }
}