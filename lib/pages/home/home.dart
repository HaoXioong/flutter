import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/colors.dart';
import 'package:flutter_app/model/wallet.dart';
import 'dart:convert';
import 'package:flutter_app/router/application.dart';
import 'package:flutter_app/common/icon.dart';
import 'package:flutter_app/config/http.dart';
import 'package:flutter_app/config/api.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/provider/user_provider.dart';
import 'package:flutter_app/provider/wallet_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState(){
    
    super.initState();
    Future.delayed(Duration.zero, (){
      _onGetWalletList();
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    
    // _onGetWalletInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
        backgroundColor: green,
      // ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: ScreenUtil.getInstance().setHeight(253),
                    padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(30),top: ScreenUtil.getInstance().setWidth(26), right: ScreenUtil.getInstance().setWidth(30)),
                    decoration: BoxDecoration(
                      color: green,                     
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          AntdIcons.saoyisao,
                          size: ScreenUtil.getInstance().setSp(36),
                          color: yellow,
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: (){
                              Application.router.navigateTo(
                                context, 
                                '/switchwallet'
                              );
                            },
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'POC',
                                  style: TextStyle(color: yellow, fontSize: ScreenUtil.getInstance().setSp(34),fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  AntdIcons.pull,
                                  size: ScreenUtil.getInstance().setSp(36),
                                  color: yellow,
                                ),
                              ],
                            ),
                          )
                        ),
                        Icon(
                          AntdIcons.zhuanzhang,
                          size: ScreenUtil.getInstance().setSp(36),
                          color: yellow,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height-299,
                    padding: EdgeInsets.only(top:ScreenUtil.getInstance().setHeight(160)),
                    decoration: BoxDecoration(
                      color: bgColor
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left:ScreenUtil.getInstance().setHeight(30), right:ScreenUtil.getInstance().setHeight(30), bottom: ScreenUtil.getInstance().setHeight(22)),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('POC钱包1', style: TextStyle(color: grey, fontSize: ScreenUtil.getInstance().setSp(24))),
                              Icon(
                                AntdIcons.tianjia,
                                size: ScreenUtil.getInstance().setSp(43),
                                color: lightgreen,
                              )
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 210,
                          width: MediaQuery.of(context).size.width - ScreenUtil.getInstance().setWidth(60),
                          child: Selector(
                            builder: (BuildContext context, list, child){
                              return ListView.builder(
                                itemCount: list.length,
                                itemBuilder: (context, int index){
                                  return _listWidget(list, index);
                                },
                              );
                            },
                            selector: (BuildContext context, WalletLists walletlists) {
                              return walletlists.currencyList;
                            },
                          )
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: ScreenUtil.getInstance().setHeight(118),
              left: ScreenUtil.getInstance().setWidth(30),
              child: _currentWallet(),
            )
          ],
        )
      )
    );
  }

  Widget _currentWallet(){
    return Container(
      padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(32)),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width - ScreenUtil.getInstance().setWidth(60),
      height: ScreenUtil.getInstance().setHeight(280),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg3.png"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(4)),
        boxShadow: []
      ),
      child: Consumer<WalletLists>(builder: (context, WalletLists walletLists, child)=>Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(walletLists.currentWallet.nickname, style: TextStyle(color: grey, fontSize: ScreenUtil.getInstance().setSp(24))),
                Icon(
                  AntdIcons.more1,
                  size: ScreenUtil.getInstance().setSp(43),
                  color: grey,
                )
              ],
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(45), bottom: ScreenUtil.getInstance().setHeight(10)),
              child: Text(
                walletLists.walletInfo.balances[0],
                style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(60), color: black, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(walletLists.currentWallet.name, style: TextStyle(color: grey, fontSize: ScreenUtil.getInstance().setSp(24))),
                Icon(
                  AntdIcons.fuzhi,
                  size: ScreenUtil.getInstance().setSp(24),
                  color: grey,
                )
              ],
            ),
          ],
        ),
      )
    );
  }
  
  Widget _listWidget(List newlist, int index){
    return InkWell(
      onTap: (){},
      child: Container(
        margin: EdgeInsets.only(bottom: ScreenUtil.getInstance().setWidth(20)),
        padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(20),right: ScreenUtil.getInstance().setWidth(20),top: ScreenUtil.getInstance().setWidth(25),bottom: ScreenUtil.getInstance().setWidth(25)),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(8)))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                // Icon(
                //   AntdIcons.newlist[index]['symbol'].toLowerCase(),
                //   size: ScreenUtil.getInstance().setSp(50),
                //   color: yellow,
                // ),
                _drawIcon(newlist[index]['symbol'].toLowerCase()),
                Container(
                  padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(10)),
                  child: Text(
                    newlist[index]['symbol'],
                    style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(24), color: black)
                  ),
                )
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  newlist[index]['number'],
                  style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(24),color: black)
                ),
                Text(
                  (double.parse(newlist[index]['price'])* double.parse(newlist[index]['number'])).toStringAsFixed(4),
                  style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(24),color: grey)
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _drawIcon(symbol) {
    switch (symbol) {
      case 'btc':
        return  Icon(
          AntdIcons.btc,
          size: ScreenUtil.getInstance().setSp(50),
          color: yellow,
        );
        break;
      case 'eos':
        return  Icon(
          AntdIcons.eos,
          size: ScreenUtil.getInstance().setSp(50),
          color: grey,
        );
        break;
      case 'eth':
        return  Icon(
          AntdIcons.eth,
          size: ScreenUtil.getInstance().setSp(50),
          color: grey,
        );
        break;
      case 'poc':
        return  Icon(
          AntdIcons.poc,
          size: ScreenUtil.getInstance().setSp(50),
          color: yellow,
        );
        break;
      default:
        break;
    }
  }

  void _onGetWalletList() async{
    final token = Provider.of<User>(context).token;
    var res = await HttpUtil().getWithToken(Api.GetCardList+"?page=${1}&rows=${10}", token);
    var walletList = json.decode(res.toString());
    WalletList wlist = WalletList.fromJson(walletList);
    print(wlist.data);
    Provider.of<WalletLists>(context).getWalletList(wlist.data);
    var current = Provider.of<WalletLists>(context).currentWallet;
    print('current--->${current}');
    if(current != null){
      print("askfjaskf---->hsdjfhsk");
      var name = Provider.of<WalletLists>(context).currentWallet.name;
      var type = Provider.of<WalletLists>(context).currentWallet.type;
      _onGetWalletInfo(type, name);
    }else{
      Provider.of<WalletLists>(context).setCurrenWallet(wlist.data[0]);
      var name = wlist.data[0].name;
      var type = wlist.data[0].type;
      _onGetWalletInfo(type, name);
    }
  }

  void _onGetWalletInfo(type, name) async{
    final token = Provider.of<User>(context).token;
    var types = ['', 'poc', 'eos', 'eth', 'btc'];
    var data = {
      "type": type,
      "name": name
    };
    var res = await HttpUtil().getWithToken('card/${types[type]}/info', token, data: data);
    var currentList = json.decode(res.toString());
    CurrentWalletInfo list = CurrentWalletInfo.fromJson(currentList);
    print(list.balances);
    Provider.of<WalletLists>(context).setCurrenWalletInfo(list);
    print('currencylist---->${Provider.of<WalletLists>(context).currencyList}');
  }
}