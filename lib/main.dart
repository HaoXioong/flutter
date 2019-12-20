import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_app/pages/splash.dart';
import 'package:flutter_app/router/application.dart';
import 'package:flutter_app/router/router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/provider/user_provider.dart';
import 'package:flutter_app/provider/wallet_provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<User>.value(value: User()),
        ChangeNotifierProvider<WalletLists>.value(value: WalletLists())
      ],
      child: MyApp(),
    )
  );

} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: Application.router.generator,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
    );
  }
}