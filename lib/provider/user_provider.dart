import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';

class User with ChangeNotifier {
  Login _data  ;
  String get token => _data.token;
  String get phone => _data.phone;
  // BuildContext get context => null;

  getUserInfo(Login param) async {
    print(param);
    _data = param;
  }

}
