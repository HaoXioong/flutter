import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/index.dart';
import 'package:flutter_app/pages/login/login.dart';
import 'package:flutter_app/pages/login/loginpwd.dart';
import 'package:flutter_app/pages/home/switchwallet.dart';
import 'package:flutter_app/pages/splash.dart';

Handler rootHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return Splash();
  }
);

Handler loginHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return Login();
  }
);

Handler loginpwdHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String account = params['account'].first;
    print('login>loginpwd phone is ${account}');
    return LoginPwd(account);
  }
);

Handler indexHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return Index();
  }
);

Handler switchWalletHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return SwitchWallet();
  }
);