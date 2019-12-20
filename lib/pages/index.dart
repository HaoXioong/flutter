import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home/home.dart';
import 'package:flutter_app/pages/my/my.dart';
import 'package:flutter_app/pages/search/search.dart';
import 'package:flutter_app/pages/travel/travel.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          Home(),
          Search(),
          Travel(),
          My()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index){
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _defaultColor),
            activeIcon: Icon(Icons.home, color: _activeColor),
            title: Text('首页', style: TextStyle(
              color: _currentIndex != 0 ? _defaultColor : _activeColor
            ))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: _defaultColor),
            activeIcon: Icon(Icons.search, color: _activeColor),
            title: Text('搜索', style: TextStyle(
              color: _currentIndex != 1 ? _defaultColor : _activeColor
            ))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt, color: _defaultColor),
            activeIcon: Icon(Icons.camera_alt, color: _activeColor),
            title: Text('旅拍', style: TextStyle(
              color: _currentIndex != 2 ? _defaultColor : _activeColor
            ))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: _defaultColor),
            activeIcon: Icon(Icons.person, color: _activeColor),
            title: Text('我的', style: TextStyle(
              color: _currentIndex != 3 ? _defaultColor : _activeColor
            ))
          )
      ]),
    );
  }
}