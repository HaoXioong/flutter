import 'package:flutter/material.dart';

class My extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('我的'),
      )
    );
  }
}