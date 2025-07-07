<<<<<<< HEAD
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Cart_page.dart';
import 'Payment_address.dart';
=======
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quotetowallpaper/payment_page.dart';

import 'Cart_page.dart';
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String? selectedColor;
  String? selectedStorage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text("Product Details", style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () async {
                final user = FirebaseAuth.instance.currentUser;
                final uid = user?.uid;

                if (uid == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please login to add to Wishlist")),
                  );
                  return;
                }

                final existing = await FirebaseFirestore.instance
                    .collection('Wishlist')
                    .where('uid', isEqualTo: uid)
                    .where('productId', isEqualTo: widget.productId)
                    .limit(1)
                    .get();

                if (existing.docs.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Product already in your Wishlist!')),
                  );
                  return;
                }

                final productDoc = await FirebaseFirestore.instance
                    .collection('products')
                    .doc(widget.productId)
                    .get();

                if (!productDoc.exists) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Product not found!')),
                  );
                  return;
                }

                final productData = productDoc.data() as Map<String, dynamic>;

                await FirebaseFirestore.instance.collection('Wishlist').add({
                  'uid': uid,
                  'productId': widget.productId,
                  'name': productData['name'],
                  'price': productData['price'],
                  'image': productData['image'],
                  'quantity': 1,
                  'timestamp': Timestamp.now(),
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Product added to your Wishlist!')),
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.favorite_border, color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage()));
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
              ),
            ),
          ),
=======
        title: const Text("Product Details"),
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () async {
            final productDoc = await FirebaseFirestore.instance
                .collection('products')
                .doc(widget.productId)
                .get();

            if (productDoc.exists) {
              final productData = productDoc.data() as Map<String, dynamic>;

              await FirebaseFirestore.instance.collection('Wishlist').add({
                'productId': widget.productId,
                'name': productData['name'],
                'price': productData['price'],
                'image': productData['image'],
                'quantity': 1,
                'timestamp': Timestamp.now(),
              });

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Product added to your Wishlist!')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Product not found!')),
              );
            }
          },),
          IconButton(icon: const Icon(Icons.shopping_cart_outlined), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
          }),
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('products')
            .doc(widget.productId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final doc = snapshot.data;
          if (!doc!.exists) {
            return const Center(child: Text("Product not found"));
          }

          final data = doc.data() as Map<String, dynamic>;
<<<<<<< HEAD

          final imageUrl = data['image'] ?? '';
=======
          final images = List<String>.from(data['images'] ?? []);
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
          final name = data['name'] ?? 'Unnamed';
          final brand = data['brand'] ?? 'Unknown';
          final rating = data['rating']?.toString() ?? '0';
          final reviews = data['reviews']?.toString() ?? '0';
          final price = data['price'] ?? 0;
          final originalPrice = data['originalPrice'] ?? 0;
<<<<<<< HEAD

          final colors = data['colors'] is List ? List<String>.from(data['colors']) : [];
          final storageOptions = data['storageOptions'] is List ? List<String>.from(data['storageOptions']) : [];
          final features = data['features'] is List ? List<String>.from(data['features']) : [];
=======
          final colors = List<String>.from(data['colors'] ?? []);
          final storageOptions = List<String>.from(data['storageOptions'] ?? []);
          final features = List<String>.from(data['features'] ?? []);
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6

          selectedColor ??= colors.isNotEmpty ? colors.first : null;
          selectedStorage ??= storageOptions.isNotEmpty ? storageOptions.first : null;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
<<<<<<< HEAD
                Center(
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                    imageUrl,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 100),
                  )
                      : const Icon(Icons.image_not_supported, size: 100),
                ),
                const SizedBox(height: 16),

                Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text("By $brand", style: const TextStyle(color: Colors.blue)),

=======
                // 📷 Main Image
                Center(
                  child: images.isNotEmpty
                      ? Image.network(images.first, height: 250)
                      : const Icon(Icons.image_not_supported, size: 100),
                ),
                const SizedBox(height: 8),

                // 📷 Thumbnail Gallery
                if (images.length > 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: images.map((img) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Image.network(img, height: 50, width: 50),
                      );
                    }).toList(),
                  ),
                const SizedBox(height: 16),

                // 📝 Title and Brand
                Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text("By $brand", style: const TextStyle(color: Colors.blue)),

                // ⭐ Rating
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 18),
                    Text(" $rating ($reviews reviews)"),
                  ],
                ),
                const SizedBox(height: 16),

<<<<<<< HEAD
=======
                // 💵 Price
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                Row(
                  children: [
                    Text(
                      "₹$price",
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "₹$originalPrice",
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

<<<<<<< HEAD
=======
                // 🎨 Color Options
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                if (colors.isNotEmpty) ...[
                  const Text("Color", style: TextStyle(fontWeight: FontWeight.bold)),
                  Wrap(
                    spacing: 10,
                    children: colors.map((color) {
                      return ChoiceChip(
                        label: Text(color),
                        selected: selectedColor == color,
                        onSelected: (_) => setState(() => selectedColor = color),
                      );
                    }).toList(),
                  ),
                ],
                const SizedBox(height: 16),

<<<<<<< HEAD
=======
                // 💽 Storage Options
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                if (storageOptions.isNotEmpty) ...[
                  const Text("Storage", style: TextStyle(fontWeight: FontWeight.bold)),
                  Wrap(
                    spacing: 10,
                    children: storageOptions.map((storage) {
                      return ChoiceChip(
                        label: Text(storage),
                        selected: selectedStorage == storage,
                        onSelected: (_) => setState(() => selectedStorage = storage),
                      );
                    }).toList(),
                  ),
                ],
                const SizedBox(height: 16),

<<<<<<< HEAD
=======
                // ✅ Features
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                const Text("A Snapshot View", style: TextStyle(fontWeight: FontWeight.bold)),
                ...(features.isNotEmpty
                    ? features.map((f) => ListTile(
                  leading: const Icon(Icons.check),
                  title: Text(f),
                ))
                    : [const Text("No features available")]),
                const SizedBox(height: 16),

<<<<<<< HEAD
=======
                // 🛍 Action Buttons
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
<<<<<<< HEAD
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentAddress(
                                productId: widget.productId,
                                totalPrice: price,
                              ),
                            ),
                          );
=======
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CardPaymentPage()));
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                        },
                        child: const Text("Buy Now"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
<<<<<<< HEAD
                          final user = FirebaseAuth.instance.currentUser;
                          final uid = user?.uid;

=======
                          FirebaseFirestore.instance.collection(user)
                          final user = FirebaseFirestore.instance.currentUser; // Replace with actual user ID
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                          final productDoc = await FirebaseFirestore.instance
                              .collection('products')
                              .doc(widget.productId)
                              .get();

<<<<<<< HEAD
                          if (!productDoc.exists) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Product not found!')),
                            );
                            return;
                          }

                          final productData = productDoc.data() as Map<String, dynamic>;

                          await FirebaseFirestore.instance.collection('cart').add({
                            'uid': uid,
                            'productId': widget.productId,
                            'name': productData['name'],
                            'price': productData['price'],
                            'image': productData['image'],
                            'quantity': 1,
                            'timestamp': Timestamp.now(),
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Product added to cart!')),
                          );
                        },
                        child: const Text("Add to Cart"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
=======
                          if (productDoc.exists) {
                            final productData = productDoc.data() as Map<String, dynamic>;
  
                            await FirebaseFirestore.instance.collection('cart').add({
                              'uid': FirebaseFirestore.instance.currentuser, // Replace with actual user ID
                              'productId': widget.productId,
                              'name': productData['name'],
                              'price': productData['price'],
                              'image':  productData['images'],
                              'quantity': 1,
                              'timestamp': Timestamp.now(),
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Product added to cart!')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Product not found!')),
                            );
                          }
                        },
                        child: const Text("Add to Cart"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
