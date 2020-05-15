import 'package:flutter/material.dart';

class ItemDashboard extends StatelessWidget {
  final String nome;
  final IconData icone;
  final Function onClick;

  const ItemDashboard({Key key, this.nome, this.icone, @required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: this.onClick,
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  this.icone,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  this.nome,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
