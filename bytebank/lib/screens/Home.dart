import 'package:bytebank/screens/transferencias/Lista.dart';
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
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu),
          ),
        ),
        title: Text("ByteBank"),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              accountName: Text('Adriano Maciel'),
              accountEmail: Text('adriano_mail@hotmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://pt.gravatar.com/userimage/14360141/7b0784cb76cfc45c02ebe3e88f0bbe14?size=200'),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.list),
                    title: Text("Transferências"),
                    onTap: () {
                      Navigator.of(context).pop();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ListaTransferencias()),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(22.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '© 2020 - Wead Technology',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
