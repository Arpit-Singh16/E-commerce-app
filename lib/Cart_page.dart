import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< HEAD
import 'Payment_address.dart';
=======
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [];
  bool isLoading = true;
  int totalPrice = 0;

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final snapshot = await FirebaseFirestore.instance
          .collection('cart')
          .where('uid', isEqualTo: user!.uid)
          .get();

      final items = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      if (!mounted) return;
      setState(() {
        cartItems = items;
        isLoading = false;
        totalPrice = calculateTotal(items);
      });
    } catch (e) {
      print("❌ Error: $e");
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  int calculateTotal(List<Map<String, dynamic>> items) {
    int total = 0;

    for (var item in items) {
      if (item is Map<String, dynamic>) {
        final dynamic rawPrice = item['price'];
        final int price = rawPrice is String
            ? int.tryParse(rawPrice) ?? 0
            : rawPrice is int
            ? rawPrice
            : rawPrice is double
            ? rawPrice.round()
            : 0;

        final dynamic rawQuantity = item['quantity'];
        final int quantity = rawQuantity is int
            ? rawQuantity
            : int.tryParse(rawQuantity?.toString() ?? '') ?? 1;

        total += price * quantity;
      }
    }

    return total;
  }

  Future<void> updateQuantity(String docId, int newQty) async {
    if (newQty <= 0) {
      await removeItem(docId);
      return;
    }

    await FirebaseFirestore.instance.collection('cart').doc(docId).update({
      'quantity': newQty,
    });

    fetchCartItems();
  }

  Future<void> removeItem(String docId) async {
    await FirebaseFirestore.instance.collection('cart').doc(docId).delete();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item removed from cart')),
    );
    fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        centerTitle: true,
        title: const Text("🛒 Your Cart",style: TextStyle(color: Colors.white),),
=======
        title: const Text("🛒 Your Cart"),
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartItems.isEmpty
          ? const Center(child: Text("🛒 Cart is empty"))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                final id = item['id'];
<<<<<<< HEAD
                final image = item['image'];
=======
                final image = item['image'] ?? '';
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                final name = item['name'] ?? 'Unnamed';

                final dynamic rawQuantity = item['quantity'];
                final int quantity = rawQuantity is int
                    ? rawQuantity
                    : int.tryParse(rawQuantity?.toString() ?? '') ?? 1;

                final dynamic rawPrice = item['price'];
                final int price = rawPrice is String
                    ? int.tryParse(rawPrice) ?? 0
                    : rawPrice is int
                    ? rawPrice
                    : rawPrice is double
                    ? rawPrice.round()
                    : 0;

                print("🛒 Item $index: $item");

                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: image != ''
                          ? Image.network(image,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover)
                          : const Icon(Icons.image_not_supported,
                          size: 40),
                    ),
                    title: Text(name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        "₹$price × $quantity = ₹${price * quantity}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon:
                          const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            updateQuantity(id, quantity - 1);
                          },
                        ),
                        Text('$quantity'),
                        IconButton(
                          icon:
                          const Icon(Icons.add_circle_outline),
                          onPressed: () {
                            updateQuantity(id, quantity + 1);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total:",
                    style: TextStyle(
                        color: Colors.white, fontSize: 18)),
<<<<<<< HEAD
                InkWell(
                  onTap: () {
                    if (totalPrice > 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentAddress(
                  totalPrice: totalPrice,
                  productId: '',
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cart is empty')),
                      );
                    }
                  },
                  child: Container(
                    color: Colors.white,
                    height: 80,
                    width: 200,
                    child: Column(
                      children:[
                        Text("Checkout",style: TextStyle(fontSize: 30),),
                        Text("₹$totalPrice",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ]),
                  ),
                ),

=======
                Text("₹$totalPrice",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
              ],
            ),
          ),
        ],
      ),
    );
  }
}
