import 'package:flutter/material.dart';

import '../Catagorypage.dart';

class Card_asset extends StatefulWidget {
  final String text;
  final  String image;
  const Card_asset({super.key, required this.text, required this.image});

  @override
  State<Card_asset> createState() => _Card_assetState();
}

class _Card_assetState extends State<Card_asset> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AspectRatio(
        aspectRatio: 15,
        child:
            InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Catagorypage(text: widget.text,)));
            },
              child: Card(
                color: Colors.transparent,
                margin: EdgeInsets.all(5),
                shadowColor: Colors.grey,
                // Circle with icon
                child: Column(
                  children:[ Expanded(
                      flex: 5,
                      child: Image.asset(widget.image,fit: BoxFit.cover,)

                  ),
                      Expanded(
                      flex: 2,
                      child: Text("${widget.text}",style: TextStyle(color: Colors.black),)),
                  ],
              ),
                    ),
            ),



      ),
    );
  }
}
