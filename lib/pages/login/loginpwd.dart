import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_app/common/colors.dart';
import 'package:flutter_app/common/icon.dart';
import 'package:flutter_app/config/http.dart';
import 'package:flutter_app/router/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/config/api.dart';
import 'package:flutter_app/utils/encrypt.dart';
import 'package:flutter_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

class LoginPwd extends StatefulWidget {
  final String account;
  LoginPwd(this.account);
  @override
  _LoginPwdState createState() => _LoginPwdState(account);
}

class _LoginPwdState extends State<LoginPwd> {
  TextEditingController _accountController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  GlobalKey _formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  bool _isClickEye = true;
  final String account;
  _LoginPwdState(this.account);

  @override
  void initState(){
    _accountController.text = account;
  }

  @override
  Widget build(BuildContext context) {

    
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      backgroundColor: green,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(130)),
                    child: Icon(
                      AntdIcons.logopoc,
                      size: ScreenUtil.getInstance().setSp(126),
                      color: yellow,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(12)),
                    child: Text(
                      'Potato Wallet',
                      style: TextStyle(color: white, fontSize: ScreenUtil.getInstance().setSp(36)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(65)),
                    width: ScreenUtil.getInstance().setWidth(693),
                    height: ScreenUtil.getInstance().setHeight(720),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(8))),
                    ),
                    child: Form(
                      key: _formKey,
                      autovalidate: autoValidate,
                      child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment(-1, -1),
                          margin: EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(66)),
                          padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(56)),
                          child: Text(
                            '登录',
                            style: TextStyle(color: black, fontSize: ScreenUtil.getInstance().setSp(32)),
                          ),
                        ),
                        SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                        Container(
                          padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(56), right: ScreenUtil.getInstance().setWidth(56)),
                          child: TextFormField(
                            enabled: false,
                            cursorColor: yellow,
                            decoration: InputDecoration(
                              prefix: Text(
                                '+86   ',
                                style: TextStyle(color: black)
                              )
                            ),
                            controller: _accountController,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(56), right: ScreenUtil.getInstance().setWidth(56)),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _isClickEye,
                            decoration: InputDecoration(
                              hintText: '请输入密码', 
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: yellow, width: 1, style: BorderStyle.solid)),                     
                              suffixIcon: IconButton(
                                icon: Icon(_isClickEye ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
                                onPressed:(){
                                  setState(() {
                                    _isClickEye = !_isClickEye;
                                  });
                                }
                              ),
                            ),
                            validator: (String value){
                              var isPhone = RegExp("[0-9A-Za-z]{8,16}");
                              if(!isPhone.hasMatch(value)){
                                return '请输入8-16位数字字母组合';
                              }
                            }
                          ),
                        ),
                        Container(
                          alignment: Alignment(1, -1),
                          margin: EdgeInsets.fromLTRB(0, ScreenUtil.getInstance().setWidth(10), ScreenUtil.getInstance().setWidth(56), ScreenUtil.getInstance().setWidth(60)),
                          child: GestureDetector(
                            child: Text(
                              '忘记密码？',
                              style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setSp(24), 
                                color: grey
                              )
                            ),
                          )
                        ),
                        SizedBox(height: ScreenUtil.getInstance().setHeight(60)),
                        Container(
                          width: ScreenUtil.getInstance().setWidth(568),
                          height: ScreenUtil.getInstance().setHeight(80),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(8))),
                          ),
                          child: Consumer<User>(
                            builder: (context, User user , child)=>RaisedButton(
                              child: Text(
                                '登录', 
                                style: TextStyle(color: white, fontSize: ScreenUtil.getInstance().setSp(32))
                              ),
                              onPressed: (){
                                if((_formKey.currentState as FormState).validate()){                              
                                  _onLogin(user);
                                }else{
                                  setState(() {
                                    autoValidate = true;
                                  });
                                }
                              },
                            ),
                          )
                        )
                      ],
                    )
                    )
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment(-1, -1),
              padding: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(32)),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      AntdIcons.back,
                      size: ScreenUtil.getInstance().setSp(40),
                      color: yellow,
                    ),
                    
                    onPressed: (){
                      Application.router.navigateTo(context, '/');
                    },
                  ),
                  Text('返回', style: TextStyle(color: yellow, fontSize: ScreenUtil.getInstance().setSp(30)))
                ],
              )
            )
          ],
        )
      ),
    );
  }

  Future _onLogin(param) async{
    var regPhone = RegExp("^(0|86|17951)?(13[0-9]|15[012356789]|166|17[3678]|18[0-9]|14[57])[0-9]{8}");
    var pwd = await Generate.generatePassword(_passwordController.text);
    var data = regPhone.hasMatch(_accountController.text) ? {
      'phone': '86-'+_accountController.text,
      'password': pwd
    } : {
      'email': _accountController.text,
      'password': pwd
    };
    var res = await HttpUtil().post(Api.Login, data: data);
    Map userMap = json.decode(res.toString());
    var user = Login.fromJson(userMap);
    // print(user);
    if(user.tp != 0){
      param.getUserInfo(user);
      Application.router.navigateTo(context, '/index');
    }else{

    }
  }
}