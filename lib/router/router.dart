import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/router/route_handlers.dart';

class Routes {
  static String root = '/';
  static String login = '/login';
  static String loginpwd = '/loginpwd';
  static String index = '/index';
  static String switchwallet = '/switchwallet';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('route not found !!!!');
      }
    );
    router.define(root, handler: rootHandler);
    router.define(login, handler: loginHandler);
    router.define(loginpwd, handler: loginpwdHandler);
    router.define(index, handler: indexHandler);
    router.define(switchwallet, handler: switchWalletHandler);
  }
}