import 'package:flutter/material.dart';

class CustomBigButtons extends StatefulWidget {
  final String text;

  const CustomBigButtons({super.key, required this.text});

  @override
  State<CustomBigButtons> createState() => _CustomBigButtonsState();
}

class _CustomBigButtonsState extends State<CustomBigButtons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
          height: 20,
          width: 20,
          child: ElevatedButton(onPressed: (){}, child: Text(widget.text))
      )
      ,
    );
  }
}
