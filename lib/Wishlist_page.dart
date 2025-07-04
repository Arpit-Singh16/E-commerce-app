import 'package:flutter/material.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {

  List<Widget> items=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order your favourite items"),
      ),
      // body: Card(
      //   child: ListView.builder(itemBuilder: (context), index) {
      //     return ListTile(
      //       leading: CircleAvatar(
      //         backgroundImage: NetworkImage(
      //             "https://example.com/image.jpg"), // Replace with actual image URL
      //       ),
      //       title: Text("Item $index"),
      //       subtitle: Text("Description of item $index"),
      //       trailing: IconButton(
      //         icon: Icon(Icons.delete),
      //         onPressed: () {
      //           // Handle delete action
      //           ScaffoldMessenger.of(context).showSnackBar(
      //             SnackBar(content: Text('Item $index removed from wishlist')),
      //           );
      //         },
      //       ),
      //     );
      //   }, itemCount: items .length, // Replace with actual item count
      //   ),
      // ),
    );
  }
}
