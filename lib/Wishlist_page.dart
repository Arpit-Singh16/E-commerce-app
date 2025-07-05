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

  @override
  void initState() {
    super.initState();
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
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
    );
  }
}
