import 'dart:async';
import 'dart:convert';

import 'package:escol/modules/firebase/bloc/firebaseBloc.dart';
import 'package:escol/modules/firebase/models/firebaseUserModel.dart';
import 'package:escol/modules/firebase/repositories/firebaseAuthRepository.dart';
import 'package:escol/modules/shared/repositories/sharePreferencesRepository.dart';
import 'package:escol/modules/shared/getItRepository.dart';
import 'package:escol/modules/shared/models/responseDefaultModel.dart';
import 'package:escol/modules/shared/utils/sharePreferencesTyped.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
part 'mainLoginPageController.g.dart';

class MainLoginPageController = _MainLoginPageControllerBase with _$MainLoginPageController;

abstract class _MainLoginPageControllerBase with Store {
  
  final FirebaseAuthRepository _authRepository = FirebaseAuthRepository(); 
  final _getShareTyped = SharedPreferncesTyped();
  final _firebasebloc = Firebasebloc();
  
  final SharePreferencesRepository _sharedPreference = SharePreferencesRepository();

  _MainLoginPageControllerBase(){
     authenticatedCurrentUser();
  }

  @observable
  ObservableFuture<ResponseDefaultModel<User>> login;

  Stream<bool> get isLogged => _firebasebloc.getUserIsLoggedController.stream;

  Future<void> authenticatedCurrentUser() async {
    var _completer = Completer<ResponseDefaultModel<User>>();
    login = _completer.future.asObservable();
    var _result = await _authRepository.authenticatedCurrentUser().asObservable();
    if(_result.isSuccess && _result.data != null){
      var _userModel = await _getShareTyped.getInfoShareTyped<FirebaseUserModel>(
        'firebaseUserModel', 
        (responseBody){
          return FirebaseUserModel.fromJson(json.decode(responseBody), dateToString: true);
        }
      );
      if(_userModel != null){
        if(!locator.isRegistered<FirebaseUserModel>()){
          locator.registerSingleton<FirebaseUserModel>(_userModel); 
        }
        _firebasebloc.getUserIsLoggedController.add(_result.isSuccess);
      }else{
        _completer.complete(_result);
        _sharedPreference.removeAllSharedPrerencesAsync();
          if(locator.isRegistered<FirebaseUserModel>()){
            locator.unregister<FirebaseUserModel>();
          }   
      }
    }else{
      _completer.completeError(_result);
    }
  }

}