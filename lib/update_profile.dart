import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:shared_preferences/shared_preferences.dart';
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
<<<<<<< HEAD
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController houseController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  bool isLoading = false;
=======
  var usernamecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController addresscontroller = TextEditingController();
  bool is_loading= false;
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6

  @override
  void initState() {
    super.initState();
    fetchCurrentUserData();
<<<<<<< HEAD
  }

  Future<void> fetchCurrentUserData() async {
    setState(() => isLoading = true);
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

          usernameController.text = data['username'] ?? '';
          emailController.text = data['email'] ?? '';
          phoneController.text = data['phonenumber'] ?? '';

          final address = data['address'] ?? {};
          houseController.text = address['house'] ?? '';
          streetController.text = address['street'] ?? '';
          cityController.text = address['city'] ?? '';
          stateController.text = address['state'] ?? '';
          pincodeController.text = address['pincode'] ?? '';
        } else {
          debugPrint("⚠️ User data not found in Firestore");
        }
      }
    } catch (e) {
      debugPrint("❌ Error fetching profile: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error loading profile")));
    }
    setState(() => isLoading = false);
  }

  Future<void> updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'username': usernameController.text.trim(),
        'phonenumber': phoneController.text.trim(),
        'address': {
          'house': houseController.text.trim(),
          'street': streetController.text.trim(),
          'city': cityController.text.trim(),
          'state': stateController.text.trim(),
          'pincode': pincodeController.text.trim(),
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Profile updated successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Failed to update profile: $e")),
      );
    }
  }

  Widget addressField(String label, TextEditingController controller,
      {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) => value!.isEmpty ? '$label is required' : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
=======

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
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
  }

  @override
  void dispose() {
<<<<<<< HEAD
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    houseController.dispose();
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    pincodeController.dispose();
    super.dispose();
=======
    usernamecontroller.dispose();
    emailcontroller.dispose();
    phonecontroller.dispose();
    addresscontroller.dispose();
    super.dispose();

>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text("🧑 Profile & Address", style: TextStyle(color: Colors.white)),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              addressField("Full Name", usernameController),
              addressField("Email", emailController,
                  keyboardType: TextInputType.emailAddress),
              addressField("Phone Number", phoneController,
                  keyboardType: TextInputType.phone),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              addressField("House No.", houseController),
              addressField("Street", streetController),
              addressField("City", cityController),
              addressField("State", stateController),
              addressField("Pincode", pincodeController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("💾 Save Profile & Address",
                    style: TextStyle(color: Colors.white)),
              ),
=======
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
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
            ],
          ),
        ),
      ),
    );
  }
}
