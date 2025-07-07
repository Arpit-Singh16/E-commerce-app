import 'dart:async';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Admin/Adminpage.dart';
import 'Bottom_navgation.dart';
=======
import 'Product_page.dart';
import 'json_upload.dart';
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
import 'login.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
<<<<<<< HEAD
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2)); // splash delay
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final isAdmin = userDoc.data()?['isAdmin'] ?? false;

      if (isAdmin) {
        // Show dialog for admin choice
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text("Admin Access"),
            content: const Text("You're logged in as an Admin. Where would you like to go?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // close dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const BottomNavgation()),
                  );
                },
                child: const Text("Home Page"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // close dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const Adminpage()),
                  );
                },
                child: const Text("Admin Panel"),
              ),
            ],
          ),
        );
      } else {
        // Regular user → go to home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const BottomNavgation()),
        );
      }
    } else {
      // Not logged in → go to login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                "https://plus.unsplash.com/premium_photo-1690571200236-0f9098fc6ca9?q=80&w=2232&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              ),
              radius: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              "Welcome to My App",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: Colors.blue),
=======

  @override
  void initState() {
    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                "https://plus.unsplash.com/premium_photo-1690571200236-0f9098fc6ca9?q=80&w=2232&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              ),
              radius: 200,
            ),
            Text("Welcome to My App",
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            CircularProgressIndicator(
              color: Colors.blue,
            ),
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
          ],
        ),
      ),
    );
  }
}
