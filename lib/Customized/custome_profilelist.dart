import 'package:flutter/material.dart';

class CustomeProfilelist extends StatefulWidget {
  final String? title;
  final onTap;
  final IconData icon;
  const CustomeProfilelist({super.key, required this.title,required this.onTap, required this.icon});

  @override
  State<CustomeProfilelist> createState() => _CustomeProfilelistState();
}

class _CustomeProfilelistState extends State<CustomeProfilelist> {
  @override
  Widget build(BuildContext context) {
    return  Card(
      // Optional: Wrap ListTile in a Card for elevation and styling
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(widget.icon, color: Theme.of(context).primaryColor),
        title: Text("${widget.title}", style: TextStyle(fontSize: 18.0)),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: widget.onTap,
      ),
    );
  }
}
