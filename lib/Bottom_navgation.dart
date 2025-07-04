import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quotetowallpaper/Wishlist_page.dart';

import 'Cart_page.dart';
import 'Profile_page.dart';
import 'homepage.dart';

class BottomNavgation extends StatefulWidget {
  const BottomNavgation({super.key});

  @override
  State<BottomNavgation> createState() => _BottomNavgationState();
}

class _BottomNavgationState extends State<BottomNavgation> {
  int _currentIndex = 0;
  final List<Widget> pages = [
    Homepage(),
    Wishlist(),
    Cart(),
    ProfilePage(),
  ];

  void _Ontap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // 🔍 blur effect
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black, // 🔲 translucent background
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: _Ontap,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Wishlist"),
                  BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
                ],
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white70,
                backgroundColor: Colors.transparent, // 🧊 must be transparent
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                elevation: 0, // 👌 prevent double shadow
              ),
            ),
          ),
        ),
      ),


    );
  }
}
