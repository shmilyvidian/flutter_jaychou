import 'package:flutter/foundation.dart';
import 'package:flutter_tutorial/models/resModel/responese_model.dart';
import 'package:flutter_tutorial/utils/httpRequest.dart';

class Counter with ChangeNotifier {//1
  bool _isLogin = false;
  int _count;
  List _favoriteLists = [];
  Map _userInfo = {};
  List _lists = [];

  Counter(this._count, this._favoriteLists, this._isLogin, this._lists);
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

  void login(String username, String password) async{
    _isLogin = true;
    _userInfo['username'] = username;
    _userInfo['password'] = password;
    
    notifyListeners();
  }
  void setLogin(bool _loginStatus){
    _isLogin = _loginStatus;
  }


  get count => _count;
  get favorite => _favoriteLists;
  get isLogin => _isLogin;
  get getUser => _userInfo;
  get getList => _lists;
}