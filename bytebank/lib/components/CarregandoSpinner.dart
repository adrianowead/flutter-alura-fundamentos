import 'package:flutter/material.dart';

class CarregandoSpinner extends StatelessWidget {
  final String message;

  const CarregandoSpinner({Key key, this.message = "Carregando..."}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(this.message),
            ),
          ]),
    );
  }
}
