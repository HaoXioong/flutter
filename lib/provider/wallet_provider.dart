import 'package:flutter/material.dart';
import 'package:flutter_app/model/wallet.dart';
import 'package:flutter_app/model/price.dart' as Price;
import 'package:flutter_app/config/api.dart';
import 'package:flutter_app/config/http.dart';
import 'dart:convert';

class WalletLists with ChangeNotifier {
  // WalletList walletlist ;

  List<Data> data = [];

  // String get name => data[0].name;

  getWalletList(List walletlists){
    data = walletlists;
    notifyListeners();
  }

  Data currentWallet ;

  setCurrenWallet(Data currentWallets){
    print('切换当前钱包');
    currentWallet = currentWallets;
    notifyListeners();
  }

  CurrentWalletInfo walletInfo;

  setCurrenWalletInfo(CurrentWalletInfo walletInfos){
    print('times------');
    walletInfo = walletInfos;
    setPricelist();
    notifyListeners();
  }

  Price.PriceList pricelist;

  setPricelist() async{
    var res = await HttpUtil().get(Api.PriceList);
    var prices = json.decode(res.toString());
    Price.PriceList priceList = Price.PriceList.fromJson(prices);
    pricelist = priceList;
    setcurrencyList(walletInfo);
    notifyListeners();
  }

  List currencyList = [];

  setcurrencyList(walletInfo){
    var numbers = walletInfo.balances[0].split(' ')[0];
    var symbol = walletInfo.balances[0].split(' ')[1];
    var price;
    pricelist.data.forEach((f){if(f.symbol == symbol.toLowerCase()) price = f.close;});
    Map data = {
      'number': numbers,
      'symbol': symbol,
      'price': price
    };
    List list = [];
    list.add(data);
    currencyList = list;
    notifyListeners();
  }

  

}