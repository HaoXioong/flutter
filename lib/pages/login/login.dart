import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/common/colors.dart';
import 'package:flutter_app/common/icon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/router/application.dart';
import 'package:flutter_app/config/http.dart';
import 'package:flutter_app/config/api.dart';
import 'package:flutter_app/model/user.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _accountController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool autoValidate =false;
  bool _isPhone = true;
  String _selectType = 'English';

  @override
  void initState() {
    super.initState();
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
                      child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment(-1, -1),
                          margin: EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(66)),
                          padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(56)),
                          child: Text(
                            '注册/登录',
                            style: TextStyle(color: black, fontSize: ScreenUtil.getInstance().setSp(32)),
                          ),
                        ),
                        SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                        Container(
                          padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(56), right: ScreenUtil.getInstance().setWidth(56)),
                          child: TextFormField(
                            autovalidate: autoValidate,
                            controller: _accountController,
                            decoration: InputDecoration(
                              hintText: _isPhone ? '请输入手机号' : '请输入邮箱', 
                              prefixText: _isPhone ? '+86   ' : null,
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: yellow, width: 1, style: BorderStyle.solid)),                
                            ),
                            cursorColor: yellow,
                            keyboardType: TextInputType.number,
                            validator: (String value){
                              var regPhone = RegExp("^(0|86|17951)?(13[0-9]|15[012356789]|166|17[3678]|18[0-9]|14[57])[0-9]{8}");
                              var regEmail = RegExp("([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})");
                              if(!regPhone.hasMatch(value)&&_isPhone){
                                return '手机号不正确';
                              }else if(!regEmail.hasMatch(value)&&!_isPhone){
                                print(regEmail.hasMatch(value));
                                print(_isPhone);
                                return '邮箱不正确';
                              }
                            }
                          ),
                        ),
                        SizedBox(height: ScreenUtil.getInstance().setHeight(60)),
                        Container(
                          width: ScreenUtil.getInstance().setWidth(568),
                          height: ScreenUtil.getInstance().setHeight(80),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().setWidth(8))),
                          ),
                          child: RaisedButton(
                            color: yellow,
                            child: Text(
                              '下一步', 
                              style: TextStyle(color: white, fontSize: ScreenUtil.getInstance().setSp(32))
                            ),
                            onPressed: () {
                              if((_formKey.currentState as FormState).validate()){                              
                                _doRequest();
                              }else{
                                setState(() {
                                  autoValidate = true;
                                });
                              }
                            }
                          ),
                        ),
                        SizedBox(height: ScreenUtil.getInstance().setHeight(20)),
                        Container(   
                          padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(56)),                   
                          child: Row(
                            children: <Widget>[
                              Text(
                                '注册即表示阅读并同意',
                                style: TextStyle(color: black, fontSize: ScreenUtil.getInstance().setSp(24)),
                              ),
                              GestureDetector(
                                onTap: (){},
                                child: Text(
                                  '《法律条款及隐私政策》',
                                  style: TextStyle(color: yellow, fontSize: ScreenUtil.getInstance().setSp(24)),
                                ),
                              )
                            ],
                          )
                        ),
                      ],
                    )
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(12)),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          _isPhone = !_isPhone;
                          _accountController.text = '';
                          autoValidate = true;
                        });
                      },
                      child: Text(
                        '手机/邮箱',
                        style: TextStyle(color: yellow, fontSize: ScreenUtil.getInstance().setSp(24)),
                      ),
                    )
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment(1, -1),
              padding: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(32)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: _selectType,
                  // style: TextStyle(color: white, fontSize: ScreenUtil.getInstance().setSp(30)),
                  onChanged: (String value){
                    setState(() {
                      _selectType = value;
                    });
                  },
                  icon: Icon(
                    AntdIcons.pull2,
                    size: ScreenUtil.getInstance().setSp(21),
                    color: white,
                  ),
                  items: <String>['English', '简体中文', '繁体中文']
                    .map<DropdownMenuItem<String>>((String value) {
                      return  DropdownMenuItem<String>( 
                        value: value,
                        child: Text(value, style: TextStyle(color: black, fontSize: ScreenUtil.getInstance().setSp(30)))
                      );
                    }).toList(),
                  style: TextStyle(color: white, fontSize: ScreenUtil.getInstance().setSp(30)),
                ), 
              ),
            )
          ],
        )
      ),
    );
  }

  Future _doRequest () async {
    var data = _isPhone ? {'phone': '86-' + _accountController.text} : {'email': _accountController.text};
    var res = await HttpUtil(context).post(Api.VerifyAccount, data: data);
    Map verifyMap = json.decode(res.toString());
    var verifyAccount = VerifyAccount.fromJson(verifyMap);
    if(verifyAccount.status == 1) {
      Application.router.navigateTo(
        context, 
        '/loginpwd?account=${_accountController.text}'
      );
    }
  }
}