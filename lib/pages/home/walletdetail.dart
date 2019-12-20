import 'package:flutter/material.dart';
import 'package:flutter_app/common/colors.dart';
import 'package:flutter_app/common/icon.dart';
import 'package:flutter_app/router/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class WalletDetail extends StatefulWidget {
  final String symbol;
  WalletDetail(this.symbol);
  @override
  _WalletDetailState createState() => _WalletDetailState(symbol);
}

class _WalletDetailState extends State<WalletDetail> {

  final String symbol;
  _WalletDetailState(this.symbol);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        leading: IconButton(
          icon: Icon(
            AntdIcons.back,
            size: ScreenUtil.getInstance().setSp(40),
            color: yellow,
          ),
          onPressed: (){
            Application.router.navigateTo(context, '/index');
          },
        ),
        brightness: Brightness.light,
        title: Text(symbol, style: TextStyle(color: yellow, fontSize: ScreenUtil.getInstance().setSp(40))),
      ),
    );
  }
}