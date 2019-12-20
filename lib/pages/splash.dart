import 'package:flutter/material.dart';
import 'package:flutter_app/common/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_app/router/application.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final _imageUrls = [
    "assets/images/1.png",
    "assets/images/2.png",
    "assets/images/3.png"
  ];
  bool showBtn = true;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Swiper(
            itemCount: _imageUrls.length,
            autoplay: false,
            loop: false,
            itemBuilder: (BuildContext context, int index){
              return Image.asset(
                _imageUrls[index],
                fit: BoxFit.cover,
              );
            },
            pagination: SwiperPagination(),
            onIndexChanged: (int index){
              if(index == 2){
                setState(() {
                  showBtn = false;
                });
              }else{
                setState(() {
                  showBtn = true;
                });
              }
            }
          ),
          Offstage(
            offstage: showBtn,
            child: Container(
              alignment: Alignment(0, 0.85),
              child: Container(
                width: ScreenUtil.getInstance().setWidth(260),
                height: ScreenUtil.getInstance().setHeight(80),
                child: RaisedButton(
                  onPressed: (){
                    Application.router.navigateTo(context, 
                      '/login'
                    );
                  },
                  color: Colors.blue,
                  child: Text(
                    '立即体验',
                    style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30), color: white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}