

import 'package:escol/Environments/EnvironmentsFactory.dart';
import 'package:escol/modules/shared/models/facebookModel.dart';
import 'package:escol/modules/shared/models/responseDefaultModel.dart';
import 'package:escol/modules/shared/providers/facebookProvider.dart';

class FacebookRepository {
   FacebookProvider _provider;

   FacebookRepository() {
     _provider = FacebookProvider(EnvironmentFactory.getEndPointFacebookApi);
   }

    Future<ResponseDefaultModel<FacebookModel>> getPostsAsync(String _params,String _token) async {
    return _provider.getPostsAsync(_params,_token);
  }
    

}