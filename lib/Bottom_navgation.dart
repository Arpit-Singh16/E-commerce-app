import 'dart:ui';
import 'package:flutter/material.dart';
import 'Cart_page.dart';
import 'Wishlist_page.dart';
import 'Profile_page.dart';
import 'homepage.dart';

class BottomNavgation extends StatefulWidget {
  const BottomNavgation({super.key});

  @override
  State<BottomNavgation> createState() => _BottomNavgationState();
}

class _BottomNavgationState extends State<BottomNavgation> {
  int _currentIndex = 0;

  final List<Widget> pages = const [
    Homepage(),
    WishlistPage(),
    CartPage(),
    ProfilePage(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6), // Slightly see-through black
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: _onTap,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Wishlist"),
                  BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
                ],
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white70,
                backgroundColor: Colors.transparent,
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                elevation: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
