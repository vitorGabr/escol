import 'dart:async';

import 'package:escol/modules/firebase/models/enum/typeUserEnum.dart';
import 'package:escol/modules/firebase/repositories/firebaseAuthRepository.dart';
import 'package:escol/modules/firebase/repositories/firebaseFirestoreRepository.dart';
import 'package:escol/modules/shared/repositories/sharePreferencesRepository.dart';
import 'package:escol/modules/shared/models/responseDefaultModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
part 'studentPageContoller.g.dart';

class StudentPageController = _StudentPageControllerBase
    with _$StudentPageController;

abstract class _StudentPageControllerBase with Store {
  final FirebaseAuthRepository _authRepository = FirebaseAuthRepository();
  final FirebaseFirestoreRepository _firestoreRepository =
      FirebaseFirestoreRepository();
  final SharePreferencesRepository _sharedPreference =
      SharePreferencesRepository();

  @observable
  ObservableFuture<ResponseDefaultModel<User>> login;

  @observable
  bool _isVisibility = true;

  bool get isVisibility => _isVisibility;

  @action
  void setVisibility(bool _value) {
    if (_isVisibility == _value) {
      _isVisibility = !_value;
    } else {
      _isVisibility = _value;
    }
  }

  @action
  Future<ResponseDefaultModel> signInWithEmailAndPassword(
      String email, String password) async {
    var _completer = Completer<ResponseDefaultModel<User>>();
    login = _completer.future.asObservable();

    var _result = await _authRepository
        .signInWithEmailAndPassword(email, password)
        .asObservable();

    var _uid = _result.data == null ? null : _result.data.uid;
    var _resultUser = await _firestoreRepository.getUser(_uid).asObservable();

    if (_result.isSuccess && _resultUser.isSuccess) {
      await _sharedPreference.removeAllSharedPrerencesAsync();
      await _firestoreRepository.preparingUserModelToSave(TypeUserEnum.student,
          firebaseUserModel: _resultUser.data, saveUserInFirebase: false);
    } else {
      _completer.completeError(_resultUser);
    }
    return _resultUser;
  }
}
