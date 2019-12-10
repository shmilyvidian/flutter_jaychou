import 'package:flutter/foundation.dart';
import 'package:flutter_tutorial/models/resModel/responese_model.dart';
import 'package:flutter_tutorial/utils/httpRequest.dart';
class User with ChangeNotifier {
  bool _isLogin = false;

  Map _userInfo = {};

   Future login (String account, String password, int type) async {
    
    _isLogin = true;
    _userInfo['username'] = account;
    _userInfo['password'] = password;
    String url = type == 0 ? '/login' : '/register';

    var res = await HttpUtils.request(
        url,
        method: HttpUtils.POST,
        data: {
          "password": password,
          "account": account
        }
    );
    
    Responese result = Responese.fromJson(res);

   

    notifyListeners();
    return result.data;
  }

  void setLogin(bool _loginStatus){
    _isLogin = _loginStatus;
    notifyListeners();
  }

  get isLogin => _isLogin;//3
  get getUser => _userInfo;//3

}