import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  final IconData icon;
  final Widget page;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.page,
  });

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            spreadRadius: 2,
            offset: Offset(0, 2),
          )
        ],
      ),
      margin: const EdgeInsets.all(5),
      child: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget.page),
          );
        },
        icon: Icon(widget.icon),
      ),
    );
  }
}
