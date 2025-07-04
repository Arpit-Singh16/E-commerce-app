import 'package:flutter/material.dart';

class Horizontal_card extends StatefulWidget {
  final text;
  final String image;
  const Horizontal_card({super.key, this.text, required this.image});

  @override
  State<Horizontal_card> createState() => _Horizontal_cardState();
}

class _Horizontal_cardState extends State<Horizontal_card> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 96/100,
      child: Card(
        color: Colors.transparent,
        margin: EdgeInsets.all(5),
        shadowColor: Colors.grey,
        // Circle with icon
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Image.asset(widget.image, fit: BoxFit.cover),
            ),

          ],
        ),
      ),
    );
  }
}
