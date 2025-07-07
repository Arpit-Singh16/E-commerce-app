import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Payment_sucess.dart';

class CardPaymentPage extends StatefulWidget {
  final String productId; // Keep this for Buy Now
  final int totalprice;

  const CardPaymentPage({super.key, required this.productId, required this.totalprice});

  @override
  State<CardPaymentPage> createState() => _CardPaymentPageState();
}

class _CardPaymentPageState extends State<CardPaymentPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool isProcessing = false;

  Future<bool> placeOrder() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please login to continue")),
      );
      return false;
    }

    final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if (!userDoc.exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User data not found")),
      );
      return false;
    }

    final name = userDoc['username'];
    final phone = userDoc['phonenumber'];

    try {
      if (widget.productId.isNotEmpty) {
        // Buy Now
        final productDoc = await FirebaseFirestore.instance
            .collection('products')
            .doc(widget.productId)
            .get();

        if (!productDoc.exists) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Product not found")),
          );
          return false;
        }

        final productData = productDoc.data()!;
        final orderData = {
          'uid': user.uid,
          'name': name,
          'phone': phone,
          'productId': widget.productId,
          'productName': productData['name'],
          'productImage': productData['image'],
          'price': productData['price'],
          'quantity': 1,
          'timestamp': FieldValue.serverTimestamp(),
          'status': 'Pending',
        };

        await FirebaseFirestore.instance.collection('orders').add(orderData);
      } else {
        // Cart Checkout
        final cartSnapshot = await FirebaseFirestore.instance
            .collection('cart')
            .where('uid', isEqualTo: user.uid)
            .get();

        if (cartSnapshot.docs.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Cart is empty")),
          );
          return false;
        }

        for (var doc in cartSnapshot.docs) {
          final item = doc.data();
          final orderData = {
            'uid': user.uid,
            'name': name,
            'phone': phone,
            'productId': item['productId'],
            'productName': item['name'],
            'productImage': item['image'],
            'price': item['price'],
            'quantity': item['quantity'],
            'timestamp': FieldValue.serverTimestamp(),
            'status': 'Pending',
          };

          await FirebaseFirestore.instance.collection('orders').add(orderData);
        }

        // Clear Cart After Order
        for (var doc in cartSnapshot.docs) {
          await doc.reference.delete();
        }
      }

      return true;
    } catch (e) {
      debugPrint("❌ Order failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to place order: $e")),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Card Payment"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                "Enter Card Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Cardholder Name
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Cardholder Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? "Enter cardholder name" : null,
              ),
              const SizedBox(height: 16),

              // Card Number
              TextFormField(
                controller: cardNumberController,
                decoration: const InputDecoration(
                  labelText: "Card Number",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                maxLength: 16,
                validator: (value) =>
                value!.length != 16 ? "Enter valid card number" : null,
              ),
              const SizedBox(height: 16),

              // Expiry and CVV
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: expiryController,
                      decoration: const InputDecoration(
                        labelText: "Expiry (MM/YY)",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.datetime,
                      validator: (value) =>
                      value!.isEmpty ? "Enter expiry date" : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: cvvController,
                      decoration: const InputDecoration(
                        labelText: "CVV",
                        border: OutlineInputBorder(),
                        counterText: "",
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      obscureText: true,
                      validator: (value) =>
                      value == null || value.length != 3 ? "Invalid CVV" : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isProcessing
                      ? null
                      : () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => isProcessing = true);
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const AlertDialog(
                          content: Row(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(width: 20),
                              Text("Processing Payment..."),
                            ],
                          ),
                        ),
                      );

                      final success = await placeOrder();
                      Navigator.pop(context); // Close dialog
                      setState(() => isProcessing = false);

                      if (success) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentSuccessPage(),
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Pay ₹${widget.totalprice}",style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
