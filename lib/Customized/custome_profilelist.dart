import 'package:flutter/material.dart';

class CustomeProfilelist extends StatefulWidget {
  final String? title;
<<<<<<< HEAD
  final onTap;
  final IconData icon;
  const CustomeProfilelist({super.key, required this.title,required this.onTap, required this.icon});
=======
  final Widget page;
  const CustomeProfilelist({super.key, required this.title, required this.page});
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6

  @override
  State<CustomeProfilelist> createState() => _CustomeProfilelistState();
}

class _CustomeProfilelistState extends State<CustomeProfilelist> {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return  Card(
      // Optional: Wrap ListTile in a Card for elevation and styling
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(widget.icon, color: Theme.of(context).primaryColor),
        title: Text("${widget.title}", style: TextStyle(fontSize: 18.0)),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: widget.onTap,
=======
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
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
      ),
    );
  }
}
