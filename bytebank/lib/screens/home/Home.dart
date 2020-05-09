import 'package:bytebank/screens/home/Dashboard.dart';
import 'package:bytebank/screens/menu/SideMenu.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(Icons.menu),
          ),
        ),
        title: Text("Dashboard"),
      ),
      drawer: SideMenu(),
      body: Dashboard(),
    );
  }
}
