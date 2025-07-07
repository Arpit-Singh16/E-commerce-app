import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class YourOrder extends StatefulWidget {
  const YourOrder({super.key});

  @override
  State<YourOrder> createState() => _YourOrderState();
}

class _YourOrderState extends State<YourOrder> {
  List<Map<String, dynamic>> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        debugPrint("⚠️ User not logged in");
        setState(() => isLoading = false);
        return;
      }

      debugPrint("👤 Current UID: ${user.uid}");

      final snapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('uid', isEqualTo: user.uid)
          .orderBy('timestamp', descending: true)
          .get();

      debugPrint("📦 Orders found: ${snapshot.docs.length}");
      if (snapshot.docs.isEmpty) {
        debugPrint("⚠️ No orders found for UID: ${user.uid}");
      }

      final items = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      if (!mounted) return;
      setState(() {
        orders = items;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("❌ Error fetching orders: $e");
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }

  Widget buildOrderCard(Map<String, dynamic> order) {
    final String name = order['productName'] ?? 'Unnamed Product';
    final String imageUrl = order['productImage'] ?? '';
    final int quantity = order['quantity'] ?? 1;
    final int price = order['price'] ?? 0;
    final String status = order['status'] ?? 'Processing';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: imageUrl.isNotEmpty
              ? Image.network(
            imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
            const Icon(Icons.broken_image, size: 40),
          )
              : const Icon(Icons.image_not_supported, size: 40),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Quantity: $quantity\nTotal: ₹${price * quantity}',
          style: const TextStyle(fontSize: 14),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: status.toLowerCase() == 'delivered'
                ? Colors.green.shade100
                : Colors.orange.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: status.toLowerCase() == 'delivered'
                  ? Colors.green
                  : Colors.orange.shade800,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📦 Your Orders"),
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : orders.isEmpty
          ? const Center(
        child: Text(
          "🛒 No orders yet.",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return buildOrderCard(orders[index]);
        },
      ),
    );
  }
}
