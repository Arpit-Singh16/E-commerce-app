import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotetowallpaper/Provider/Cartprovider.dart';

class CustomizedbuttonforCart extends StatefulWidget {
  final String item;
  final int price;
  const CustomizedbuttonforCart( {super.key, required this.item, required this.price});

  @override
  State<CustomizedbuttonforCart> createState() => _CustomizedbuttonforCartState();
}

class _CustomizedbuttonforCartState extends State<CustomizedbuttonforCart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<cartprovider>(
      builder: (context, provider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: (){
                if (provider.itemno > 0) {
                  provider.decrement(widget.item, widget.price);
                }
              },
              icon: const Icon(Icons.remove),
            ),
            Text(
              "${provider.itemno}",
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
            IconButton(
              onPressed: (){},
              icon: const Icon(Icons.add),
            ),
          ],
        );
      },
    );
  }
}
