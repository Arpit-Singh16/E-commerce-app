import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quotetowallpaper/payment_page.dart';

class PaymentAddress extends StatefulWidget {
  final String productId;
  final int totalPrice;

  const PaymentAddress({super.key, required this.productId, required this.totalPrice});

  @override
  State<PaymentAddress> createState() => _PaymentAddressState();
}

class _PaymentAddressState extends State<PaymentAddress> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  bool isLoading = true;
  String? userId;

  @override
  void initState() {
    super.initState();
    fetchAddress();
  }

  Future<void> fetchAddress() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        userId = user.uid;

        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

          // ✅ Fill in name
          _nameController.text = data?['username'] ?? '';

          // ✅ Fill or update phone
          if ((data?['phone'] == null || data!['phone'].toString().isEmpty) &&
              user.phoneNumber != null) {
            await FirebaseFirestore.instance.collection('users').doc(userId).set({
              'phonenumber': user.phoneNumber,
            }, SetOptions(merge: true));
            _phoneController.text = user.phoneNumber!;
          } else {
            _phoneController.text = data?['phonenumber'] ?? '';
          }

          // ✅ Fill address
          Map<String, dynamic> address = (data?['address'] ?? {}) as Map<String, dynamic>;
          _houseController.text = address['house'] ?? '';
          _streetController.text = address['street'] ?? '';
          _cityController.text = address['city'] ?? '';
          _stateController.text = address['state'] ?? '';
          _pincodeController.text = address['pincode'] ?? '';
        }
      }
    } catch (e) {
      print("Error fetching address: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to fetch address. Please try again.")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> saveAddress() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'username': _nameController.text.trim(),
          'phonenumber': _phoneController.text.trim(),
          'address': {
            'house': _houseController.text.trim(),
            'street': _streetController.text.trim(),
            'city': _cityController.text.trim(),
            'state': _stateController.text.trim(),
            'pincode': _pincodeController.text.trim(),
          }
        }, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Address saved! Proceeding to payment...")),
        );

        // Navigate to payment page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardPaymentPage(
              productId: widget.productId,
              totalprice: widget.totalPrice,
            ),
          ),
        );
      } catch (e) {
        print("Error saving address: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to save address. Please try again.")),
        );
      }
    }
  }

  Widget addressField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        validator: (value) => value!.isEmpty ? '$label is required' : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
        title: const Text("Payment Address", style: TextStyle(color: Colors.white)),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              addressField("Full Name", _nameController),
              addressField("Phone Number", _phoneController),
              addressField("House No.", _houseController),
              addressField("Street", _streetController),
              addressField("City", _cityController),
              addressField("State", _stateController),
              addressField("Pincode", _pincodeController),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: saveAddress,
                child: const Text("Confirm & Proceed to Pay",style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
