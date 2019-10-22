import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  bool _isLogin = false;

  Map _userInfo = {};

  void login(String username, String password){
    print('success');
    _isLogin = true;
    _userInfo['username'] = username;
    _userInfo['password'] = password;
    notifyListeners();
  }

  void setLogin(bool _loginStatus){
    _isLogin = _loginStatus;
    notifyListeners();
  }

  get isLogin => _isLogin;//3
  get getUser => _userInfo;//3

}