import 'package:flutter/material.dart';

class CarregandoLinear extends StatelessWidget {
  final String message;

  const CarregandoLinear({
    Key key,
    this.message = "Carregando...",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            LinearProgressIndicator(),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                this.message,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ]),
    );
  }
}
