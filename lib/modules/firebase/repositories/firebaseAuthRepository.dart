import 'package:escol/modules/firebase/providers/firebaseAuthProvider.dart';
import 'package:escol/modules/shared/models/responseDefaultModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository {

  final FirebaseAuthProvider _authProvider = FirebaseAuthProvider();

  Future<ResponseDefaultModel> logout() async {
    return  _authProvider.logout();
  }

  Future<ResponseDefaultModel<User>> authenticatedCurrentUser() async {
    return  _authProvider.authenticatedCurrentUser();
  }

  Future<ResponseDefaultModel<User>> signInWithEmailAndPassword(String email, String password) async {
    return  _authProvider.signInWithEmailAndPassword(email,password);
  }

}