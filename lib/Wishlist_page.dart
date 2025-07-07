<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  List<Map<String, dynamic>> wishlist = [];
  bool isLoading = true;
  int totalPrice = 0;
=======
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<Map<String, dynamic>> wishlistItems = [];
  bool isLoading = true;
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final snapshot = await FirebaseFirestore.instance
          .collection('Wishlist')
          .where('uid', isEqualTo: user!.uid)
          .get();

      final items = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      if (!mounted) return;
      setState(() {
        wishlist = items;
        isLoading = false;
        totalPrice = calculateTotal(items);
      });
    } catch (e) {
      print("❌ Error: $e");
=======
    fetchWishlist();
  }

  /// Fetch wishlist items, optionally user-specific
  Future<void> fetchWishlist() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final snapshot = await FirebaseFirestore.instance
          .collection('wishlist')
          .where('uid', isEqualTo: user?.uid) // Optional: user-based filtering
          .get();

      List<Map<String, dynamic>> loadedItems = [];

      for (var doc in snapshot.docs) {
        final data = doc.data();
        data['id'] = doc.id;
        loadedItems.add(data);
        print("✅ Wishlist Item: $data");
      }

      if (!mounted) return;
      setState(() {
        wishlistItems = loadedItems;
        isLoading = false;
      });
    } catch (e) {
      print('❌ Error loading wishlist: $e');
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

<<<<<<< HEAD
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



  Future<void> removeItem(String docId) async {
    await FirebaseFirestore.instance.collection('Wishlist').doc(docId).delete();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item removed from Wishlist')),
    );
    fetchCartItems();
=======
  /// Remove item by doc ID
  Future<void> removeFromWishlist(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('wishlist').doc(docId).delete();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Removed from wishlist')),
      );
      fetchWishlist();
    } catch (e) {
      print('❌ Error removing item: $e');
    }
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: const Text("Your Wishlist",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : wishlist.isEmpty
          ? const Center(child: Text("Wishlist is empty"))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final item = wishlist[index];
                final id = item['id'];
                final image = item['image'] ?? '';
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
                          const Icon(Icons.favorite, color: Colors.red,),
                          onPressed: () {
                            removeItem(id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
=======
        title: const Text('My Wishlist', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : wishlistItems.isEmpty
          ? const Center(child: Text("❤️ No items in wishlist"))
          : ListView.builder(
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          final item = wishlistItems[index];
          final image = item['image'] ?? '';
          final name = item['name'] ?? 'Unnamed';
          final id = item['id'];

          // 🔒 Handle all price types safely
          dynamic price = item['price'];
          if (price is String) {
            price = int.tryParse(price) ?? 0;
          } else if (price is double) {
            price = price.round();
          } else if (price == null) {
            price = 0;
          }

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: image.isNotEmpty
                    ? Image.network(image,
                    width: 60, height: 60, fit: BoxFit.cover)
                    : const Icon(Icons.image_not_supported, size: 40),
              ),
              title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("₹$price"),
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  if (id != null) {
                    removeFromWishlist(id);
                  } else {
                    print("⚠️ Missing document ID for item: $name");
                  }
                },
              ),
            ),
          );
        },
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
      ),
    );
  }
}
