import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var usernamecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController addresscontroller = TextEditingController();
  bool is_loading= false;

  @override
  void initState() {
    super.initState();
    fetchCurrentUserData();

  }



  void fetchCurrentUserData() async {
    setState(() {
      is_loading= true;
    });
    try {
      User? userData = FirebaseAuth.instance.currentUser;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString("email");

      if (userData != null && email != null) {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(email) // Assuming document ID is user's email
            .get();

        if (documentSnapshot.exists) {
          Map<String, dynamic> userDataMap =
          documentSnapshot.data() as Map<String, dynamic>;

          setState(() {
            usernamecontroller.text = userDataMap['username'] ?? '';
            emailcontroller.text = userDataMap['email'] ?? '';
            phonecontroller.text = userDataMap['phoneNumber'] ?? '';
            addresscontroller.text = userDataMap['address'] ?? '';

            is_loading = false;

          });
        } else {
          print('No user data found for this user.');
        }
      } else {
        print('No user is currently logged in or email is missing.');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  void dispose() {
    usernamecontroller.dispose();
    emailcontroller.dispose();
    phonecontroller.dispose();
    addresscontroller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 100,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: usernamecontroller,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailcontroller,
                readOnly: true, // Usually email is not editable
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: phonecontroller,
                decoration: InputDecoration(
                  labelText: "Phone number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: addresscontroller,
                decoration: InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Update user data
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  var email = prefs.getString("email");

                  if (email != null) {
                    await FirebaseFirestore.instance.collection('users').doc(email).update({
                      'name': usernamecontroller.text,
                      'phoneNumber': phonecontroller.text,
                      'address': addresscontroller.text,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("✅ Profile updated")));
                  }
                },
                child: Text("Save Changes"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
