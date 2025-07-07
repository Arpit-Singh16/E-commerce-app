<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminProducts extends StatefulWidget {
  const AdminProducts({super.key});

  @override
  State<AdminProducts> createState() => _AdminProductsState();
}

class _AdminProductsState extends State<AdminProducts> {
  List<Map<String, dynamic>> products = [];
  final TextEditingController searchController = TextEditingController();
=======
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Adminproducts extends StatefulWidget {
  const Adminproducts({super.key});

  @override
  State<Adminproducts> createState() => _AdminproductsState();
}

class _AdminproductsState extends State<Adminproducts> {
  final int _limit = 10;
  final List<Map<String, dynamic>> _products = [];
  final Map<String, TextEditingController> _controllers = {};
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  DocumentSnapshot? _lastDocument;
  bool _isLoading = false;
  bool _hasMore = true;
  String _searchQuery = '';
  Timer? _debounce;
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final snapshot = await FirebaseFirestore.instance.collection('products').get();
    final data = snapshot.docs.map((doc) {
      final map = doc.data();
      map['id'] = doc.id;
      return map;
    }).toList();

    setState(() {
      products = data;
    });
  }

  Future<void> updateStock(String id, int stock) async {
    await FirebaseFirestore.instance.collection('products').doc(id).update({'stock': stock});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Stock updated')),
    );
  }

  Future<void> deleteProduct(String id) async {
    await FirebaseFirestore.instance.collection('products').doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product deleted')),
    );
    fetchProducts();
=======
    _fetchProducts();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !_isLoading &&
          _hasMore &&
          _searchQuery.isEmpty) {
        _fetchProducts();
      }
    });

    _searchController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 300), () {
        setState(() {
          _searchQuery = _searchController.text.trim().toLowerCase();
        });
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _fetchProducts() async {
    setState(() => _isLoading = true);

    try {
      Query query = FirebaseFirestore.instance
          .collection('products')
          .orderBy('name')
          .limit(_limit);

      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      }

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;

        final newProducts = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return data;
        }).toList();

        setState(() {
          _products.addAll(newProducts);
          for (var product in newProducts) {
            final id = product['id'];
            if (!_controllers.containsKey(id)) {
              _controllers[id] = TextEditingController(
                text: (product['stock'] ?? 0).toString(),
              );
            }
          }
          if (newProducts.length < _limit) _hasMore = false;
        });
      } else {
        _hasMore = false;
      }
    } catch (e) {
      debugPrint('Error fetching products: $e');
    }

    setState(() => _isLoading = false);
  }

  Future<void> _updateStock(String productId, int newStock) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .update({'stock': newStock});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Stock updated successfully!')),
      );
    } catch (e) {
      debugPrint('Error updating stock: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to update stock: $e')));
    }
  }

  Future<void> _confirmUpdateStock(String id, int newStock) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirm Stock Update'),
        content: Text('Update stock to $newStock?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Update'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      _updateStock(id, newStock);
    }
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final filtered = products.where((product) {
      final name = (product['name'] ?? '').toString().toLowerCase();
      return name.contains(searchController.text.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search by name...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final product = filtered[index];
                final stockController = TextEditingController(text: product['stock'].toString());

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.network(
                      product['image'] ?? '',
                      width: 50,
                      height: 50,
                      errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                    ),
                    title: Text(product['name'] ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price: ₹${product['price']}'),
=======
    final List<Map<String, dynamic>> filteredProducts = _searchQuery.isEmpty
        ? _products
        : _products.where((product) {
            final name = (product['name'] ?? '').toString().toLowerCase();
            return name.contains(_searchQuery);
          }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manage Products",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => _searchController.clear(),
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: filteredProducts.isEmpty
          ? const Center(child: Text("No products found"))
          : ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.all(10),
              itemCount: filteredProducts.length + (_hasMore ? 1 : 0),
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                if (index == filteredProducts.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final product = filteredProducts[index];
                final id = product['id'];
                final name = product['name'] ?? 'Unnamed Product';
                final price = product['price'] ?? 0;
                final imageUrl =
                    product['image'] ?? 'https://via.placeholder.com/150';
                final stockController = _controllers[id]!;

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                imageUrl,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.broken_image, size: 70),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Price: \$${price.toString()}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: stockController,
                                keyboardType: TextInputType.number,
<<<<<<< HEAD
                                decoration: const InputDecoration(labelText: 'Stock'),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.save, color: Colors.green),
                              onPressed: () {
                                final newStock = int.tryParse(stockController.text);
                                if (newStock != null) updateStock(product['id'], newStock);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteProduct(product['id']),
=======
                                decoration: InputDecoration(
                                  labelText: 'Stock',
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                              ),
                              onPressed: () {
                                final enteredText = stockController.text;
                                final newStock = int.tryParse(enteredText);
                                if (newStock == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Enter a valid number'),
                                    ),
                                  );
                                  return;
                                }
                                _confirmUpdateStock(id, newStock);
                              },
                              icon: const Icon(Icons.save, size: 18),
                              label: const Text(
                                "Save",
                                style: TextStyle(fontSize: 14),
                              ),
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
<<<<<<< HEAD
          ),
        ],
      ),
=======
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
    );
  }
}
