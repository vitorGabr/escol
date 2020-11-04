import 'package:escol/modules/shared/models/responseDefaultModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthProvider {

  static FirebaseAuthProvider _instanceSingleton;

  factory FirebaseAuthProvider() {
    _instanceSingleton ??= FirebaseAuthProvider._internalConstructor();

    return _instanceSingleton;
  }

  FirebaseAuthProvider._internalConstructor();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  Future<ResponseDefaultModel> logout() async {
    var result = ResponseDefaultModel();
    try { 
      await _firebaseAuth.signOut();
      result.isSuccess = true;
    } catch (e) {
      result
        ..isSuccess = false
        ..errorMessage = e.message;
    }
    return result;   
  }

  Future<ResponseDefaultModel<User>> authenticatedCurrentUser() async {

    var result = ResponseDefaultModel<User>();

    var _data = _firebaseAuth.currentUser;
    
     if (_data != null) {
        result
          ..isSuccess = true
          ..data = _data;
        return result;
     } else {
        result.isSuccess = false;
        return result;
     }

  }

  Future<ResponseDefaultModel<User>> signInWithEmailAndPassword(String email, String password) async {
    
     var _result = ResponseDefaultModel<User>();
     try{
        var  _response = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email,password: password);
        if(_response != null) {
          _result
            ..isSuccess = true
            ..data = _response.user;
        } else {
          _result.isSuccess = false;
        }
     }catch(e){
       _result
         ..isSuccess = false
         ..errorMessage = e.code;
     }
      return _result;

  }


}