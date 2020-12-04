import 'dart:async';

import 'package:escol/modules/firebase/models/firebaseUserModel.dart';
import 'package:escol/modules/firebase/repositories/firebaseAuthRepository.dart';
import 'package:escol/modules/shared/getItRepository.dart';
import 'package:escol/modules/shared/models/responseDefaultModel.dart';
import 'package:escol/modules/shared/repositories/sharePreferencesRepository.dart';
import 'package:mobx/mobx.dart';
part 'configurationPageController.g.dart';

class ConfigurationPageController = _ConfigurationPageControllerBase
    with _$ConfigurationPageController;

abstract class _ConfigurationPageControllerBase with Store {
  final FirebaseAuthRepository _authRepository = FirebaseAuthRepository();
  final SharePreferencesRepository _sharedPreference =
      SharePreferencesRepository();

  @observable
  ObservableFuture<ResponseDefaultModel> didLogout;

  @action
  Future<bool> logout() async {
    var _completer = Completer<ResponseDefaultModel>();
    didLogout = _completer.future.asObservable();
    var _result = await _authRepository.logout();
    if (_result.isSuccess) {
      _sharedPreference.removeAllSharedPrerencesAsync();
      locator.unregister<FirebaseUserModel>();
      _completer.complete(_result);
    } else {
      _completer.completeError(_result);
    }
    return _result.isSuccess;
  }
}
