import 'package:flutter/material.dart';

class CustomeProfilelist extends StatefulWidget {
  final String? title;
  final Widget page;
  const CustomeProfilelist({super.key, required this.title, required this.page});

  @override
  State<CustomeProfilelist> createState() => _CustomeProfilelistState();
}

class _CustomeProfilelistState extends State<CustomeProfilelist> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: ListTile(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>widget.page));
        },
        title: Text("${widget.title}",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.grey,),
      ),
    );
  }
}
