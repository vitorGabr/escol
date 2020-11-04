import 'package:escol/modules/shared/repositories/sharePreferencesRepository.dart';

class SharedPreferncesTyped {

  final _share = SharePreferencesRepository();

  Future<T> getInfoShareTyped<T>(String _key, T Function(String body) callback) async {

      var _mapInfo = await _share.containsKeyAsync(_key);

        if(_mapInfo.isNotEmpty) {

          var _result = callback(_mapInfo);
          
          return _result;
        }

        return null;
    }

}