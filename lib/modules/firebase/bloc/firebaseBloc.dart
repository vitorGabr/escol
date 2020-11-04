import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class Firebasebloc implements BlocBase  {

  final _userIsLoggedController = BehaviorSubject<bool>();
  
  BehaviorSubject<bool> get getUserIsLoggedController => _userIsLoggedController;  

  @override
  void dispose() {
    _userIsLoggedController.close();
  }

  @override
  void noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}