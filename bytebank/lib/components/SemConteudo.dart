import 'package:flutter/material.dart';

class SemConteudo extends StatelessWidget {
  final String message;

  const SemConteudo({Key key, this.message = "Não há conteúdo!"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.warning),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(this.message),
            ),
          ]),
    );
  }
}
