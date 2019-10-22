import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class Counter with ChangeNotifier {//1
  bool _isLogin = false;
  int _count;
  List _favoriteLists = [];
  Map _userInfo = {};
  Counter(this._count, this._favoriteLists, this._isLogin);
  void add() {
    _count++;
    notifyListeners();//2
  }

  void addFavorite(favorite){
    if(_favoriteLists.contains(favorite)){
      _favoriteLists.remove(favorite);
    }else{
      _favoriteLists.add(favorite);
    }
    notifyListeners();//2
  }

  void login(String username, String password){
    _isLogin = true;
    _userInfo['username'] = username;
    _userInfo['password'] = password;
    notifyListeners();
  }
  void setLogin(bool _loginStatus){
    _isLogin = _loginStatus;
  }

  get count => _count;//3
  get favorite => _favoriteLists;//3
  get isLogin => _isLogin;//3
  get getUser => _userInfo;//3
}