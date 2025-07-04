import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        title: const Text("Product Details"),
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {},
          ),
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

          final data = snapshot.data!.data() as Map<String, dynamic>;

          final images = List<String>.from(data['images']);
          final name = data['name'];
          final brand = data['brand'];
          final rating = data['rating'].toString();
          final reviews = data['reviews'].toString();
          final price = data['price'];
          final originalPrice = data['originalPrice'];
          final colors = List<String>.from(data['colors']);
          final storageOptions = List<String>.from(data['storageOptions']);
          final features = List<String>.from(data['features']);

          selectedColor ??= colors.first;
          selectedStorage ??= storageOptions.first;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Image
                Center(child: Image.network(images.first, height: 250)),

                const SizedBox(height: 8),

                // Thumbnail Gallery
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

                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("By $brand", style: const TextStyle(color: Colors.blue)),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 18),
                    Text(" $rating ($reviews reviews)"),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Text(
                      "\$$price",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "\$$originalPrice",
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                const Text(
                  "Color",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 10,
                  children: colors.map((color) {
                    return ChoiceChip(
                      label: Text(color),
                      selected: selectedColor == color,
                      onSelected: (val) =>
                          setState(() => selectedColor = color),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),

                const Text(
                  "Storage",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 10,
                  children: storageOptions.map((storage) {
                    return ChoiceChip(
                      label: Text(storage),
                      selected: selectedStorage == storage,
                      onSelected: (val) =>
                          setState(() => selectedStorage = storage),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),

                const Text(
                  "A Snapshot View",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...features.map(
                  (f) => ListTile(
                    leading: const Icon(Icons.check),
                    title: Text(f),
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
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
                        onPressed: () {
                          // Add to Cart functionality here
                        },
                        child: const Text("Add to Cart"),
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
