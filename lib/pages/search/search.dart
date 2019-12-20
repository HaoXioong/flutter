import 'package:flutter/material.dart';

const CITY_NAMES = ['北京', '上海', '广州', '深圳', '天津', '重庆', '成都', '武汉', '郑州', '厦门', '苏州', '南京'];
class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索'),
      ),
      body: GridView.count(
        // scrollDirection: Axis.horizontal,
        crossAxisCount: 3,
        children: _buildList(),
      )
    );
  }
  List<Widget> _buildList() {
    return CITY_NAMES.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: TextStyle(color: Colors.white, fontSize: 20)
      ),
    );
  }
}

