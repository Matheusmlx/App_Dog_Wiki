import 'package:flutter/material.dart';

class Dog_Item_Attr extends StatelessWidget {

  final String title;
  final IconData icon;

  const Dog_Item_Attr(this.title, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(icon, color: Colors.white),
        const SizedBox( height: 6),
        Text(title),
        const SizedBox( height: 6)
      ],
    );
  }
}