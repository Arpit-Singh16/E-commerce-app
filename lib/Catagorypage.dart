import 'package:flutter/material.dart';

import 'Customized/card_with_networkimage.dart';

class Catagorypage extends StatefulWidget {
  final String text;
  const Catagorypage({super.key, required this.text});

  @override
  State<Catagorypage> createState() => _CatagorypageState();
}

class _CatagorypageState extends State<Catagorypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: SafeArea(child:
GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,


),
children: [
  Horizontal_card(image: '',),
  Horizontal_card(image: '',),
  Horizontal_card(image: '',),
  Horizontal_card(image: '',),
  Horizontal_card(image: '',),
  Horizontal_card(image: '',),
  Horizontal_card(image: '',),

],

)),
    );
  }
}
