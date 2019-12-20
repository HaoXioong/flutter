import 'package:flutter/material.dart';
import 'package:flutter_app/common/colors.dart';
import 'package:flutter_app/common/icon.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/provider/wallet_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/router/application.dart';
import 'package:flutter_app/config/http.dart';
import 'package:flutter_app/config/api.dart';
import 'package:flutter_app/provider/user_provider.dart';
import 'dart:convert';
import 'package:flutter_app/model/wallet.dart';

class SwitchWallet extends StatefulWidget {
  @override
  _SwitchWalletState createState() => _SwitchWalletState();
}

class _SwitchWalletState extends State<SwitchWallet> {
  final types = ["", "POC", "EOS", "ETH", "BTC"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0.5,
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
        title: Text('钱包管理', style: TextStyle(color: yellow, fontSize: ScreenUtil.getInstance().setSp(40))),
      ),
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Selector(
              builder: (BuildContext context, walletlists, child){
                return ListView.builder(
                  padding: EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(100)),
                  itemCount: walletlists.data.length,
                  itemBuilder: (context, index) {
                    var i;
                    walletlists.data.asMap().forEach(
                      (k, v){
                        if(v.cardid == walletlists.currentWallet.cardid){
                          i = k;
                        }
                      }
                    );
                    walletlists.data.removeAt(i);
                    walletlists.data.insert(0, walletlists.currentWallet);
                    return _listWallet(walletlists.data, index, walletlists.currentWallet);
                  },
                );
              },
              selector: (BuildContext context, WalletLists walletlists){
                return walletlists;
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                margin: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(25), right: ScreenUtil.getInstance().setWidth(25)),
                width: MediaQuery.of(context).size.width - ScreenUtil.getInstance().setWidth(50),
                decoration: BoxDecoration(
                  color: bgColor
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: ScreenUtil.getInstance().setWidth(330),
                      height: ScreenUtil.getInstance().setHeight(80),
                      child: RaisedButton(
                        onPressed: (){

                        },
                        color: yellow,
                        child: Text(
                          '导入',
                          style: TextStyle(color: white, fontSize: ScreenUtil.getInstance().setSp(34)),
                        ),
                      ),
                    ),
                    Container(
                      width: ScreenUtil.getInstance().setWidth(330),
                      height: ScreenUtil.getInstance().setHeight(80),
                      child: RaisedButton(
                        onPressed: (){

                        },
                        color: lightgreen1,
                        child: Text(
                          '创建',
                          style: TextStyle(color: white, fontSize: ScreenUtil.getInstance().setSp(34))
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      )
    );
  }

  Widget _listWallet(list, index, currentWallet){
    return InkWell(
      onTap: (){
        print('list.data[index]--->${list[index]},${index}');
        Provider.of<WalletLists>(context).setCurrenWallet(list[index]);
        _onGetWalletInfo(list[index].type, list[index].name);
      },
      child: Container(
        margin: EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(30),left: ScreenUtil.getInstance().setWidth(25), right: ScreenUtil.getInstance().setWidth(25)),
        padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(32)),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width - ScreenUtil.getInstance().setWidth(50),
        height: ScreenUtil.getInstance().setHeight(170),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: currentWallet.name == list[index].name ? AssetImage("assets/images/bg2.png") : AssetImage("assets/images/bg3.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(4)),
          boxShadow: []
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(types[list[index].type], style: TextStyle(color: grey, fontSize: ScreenUtil.getInstance().setSp(24))),
                  Text(list[index].nickname, style: TextStyle(color: currentWallet.name == list[index].name ? lightgreen : green, fontSize: ScreenUtil.getInstance().setSp(24))),
                  Icon(
                    AntdIcons.more1,
                    size: ScreenUtil.getInstance().setSp(43),
                    color: grey,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(list[index].name, style: TextStyle(color: grey, fontSize: ScreenUtil.getInstance().setSp(24))),
                  Container(
                    margin: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(10)),
                    child: currentWallet.name == list[index].name ? Icon(
                      AntdIcons.gou,
                      size: ScreenUtil.getInstance().setSp(24),
                      color: lightgreen,
                    ) : null,
                  )
                ],
              ),
            ],
          ),
      ),
    );
  }

  void _onGetWalletInfo(type, name) async{
    var types = ['', 'poc', 'eos', 'eth', 'btc'];
    final token = Provider.of<User>(context).token;
    var data = {
      "type": type,
      "name": name
    };
    print('token--->${token}');
    print('data--->${data}');
    var res = await HttpUtil().getWithToken('card/${types[type]}/info', token, data: data);
    var currentList = json.decode(res.toString());
    CurrentWalletInfo list = CurrentWalletInfo.fromJson(currentList);
    print(list.balances);
    Provider.of<WalletLists>(context).setCurrenWalletInfo(list);
    print('currencylist---->${Provider.of<WalletLists>(context).currencyList}');
  }
}