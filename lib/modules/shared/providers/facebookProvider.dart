import 'dart:convert';

import 'package:escol/modules/shared/models/facebookModel.dart';
import 'package:escol/modules/shared/models/facebookPostContentModel.dart';
import 'package:escol/modules/shared/models/responseDefaultModel.dart';
import 'package:escol/modules/shared/providers/baseProvider.dart';


class FacebookProvider extends BaseProvider {
  
  FacebookProvider(String url) : super(url);

  Future<ResponseDefaultModel<FacebookModel>> getPostsAsync(String param,String token) async {
    
    var result = ResponseDefaultModel<FacebookModel>();
    return getItem(
       '$url$param\&access_token=$token', 
       (responseBody) {
        return result.data = FacebookModel.fromJson(json.decode(responseBody));
      }
    );

  }

}
