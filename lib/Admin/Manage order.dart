<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
=======
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
import 'package:flutter/material.dart';

class ManageOrder extends StatefulWidget {
  const ManageOrder({super.key});

  @override
  State<ManageOrder> createState() => _ManageOrderState();
}

class _ManageOrderState extends State<ManageOrder> {
<<<<<<< HEAD
  List<Map<String, dynamic>> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      setState(() => isLoading = true);
      final orderSnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .orderBy('timestamp', descending: true)
          .get();

      List<Map<String, dynamic>> loadedOrders = [];

      for (var doc in orderSnapshot.docs) {
        final data = doc.data();
        final uid = data['uid'];
        data['id'] = doc.id;

        if (uid != null) {
          final userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .get();
          final userData = userDoc.data();
          data['email'] = userData?['email'] ?? 'Unknown';
          data['phoneNumber'] = userData?['phoneNumber'] ?? 'Unknown';
        } else {
          data['email'] = 'Unknown';
          data['phoneNumber'] = 'Unknown';
        }

        loadedOrders.add(data);
      }

      setState(() {
        orders = loadedOrders;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching orders: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .update({'status': newStatus});
      fetchOrders(); // Refresh list
    } catch (e) {
      print("Error updating status: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to update status")),
      );
    }
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      await FirebaseFirestore.instance.collection('orders').doc(orderId).delete();
      fetchOrders();
    } catch (e) {
      print("Error deleting order: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to delete order")),
      );
    }
  }

  final List<String> orderStatuses = ['Pending', 'Shipped', 'Delivered', 'Cancelled'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Orders", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : orders.isEmpty
          ? const Center(child: Text("No orders found"))
          : ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          final timestamp = order['timestamp'] != null
              ? (order['timestamp'] as Timestamp).toDate()
              : null;

          return Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Product: ${order['productName']}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("Order ID: ${order['id']}"),
                  Text("Price: ₹ ${order['price']}"),
                  Text("User Email: ${order['email']}"),
                  Text("Phone: ${order['phoneNumber']}"),
                  if (timestamp != null)
                    Text("Ordered on: ${timestamp.toLocal()}"),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text("Status: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      DropdownButton<String>(
                        value: order['status'] ?? 'Pending',
                        items: orderStatuses.map((status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(status),
                          );
                        }).toList(),
                        onChanged: (newStatus) {
                          if (newStatus != null && newStatus != order['status']) {
                            updateOrderStatus(order['id'], newStatus);
                          }
                        },
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Confirm Delete"),
                            content: const Text("Are you sure you want to delete this order?"),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  deleteOrder(order['id']);
                                },
                                child: const Text("Delete", style: TextStyle(color: Colors.red)),
=======
  // Mock order list (you can replace this with API data later)
  final List<Map<String, dynamic>> orders = [
    {
      'orderId': 'ORD1234',
      'customer': 'John Doe',
      'status': 'Pending',
      'total': 49.99,
    },
    {
      'orderId': 'ORD5678',
      'customer': 'Jane Smith',
      'status': 'Shipped',
      'total': 89.50,
    },
    {
      'orderId': 'ORD9012',
      'customer': 'Alice Johnson',
      'status': 'Delivered',
      'total': 29.99,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Manage Orders",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: Icon(Icons.receipt_long, color: Colors.black87),
                title: Text("Order ID: ${order['orderId']}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Customer: ${order['customer']}"),
                    Text(
                      "Status: ${order['status']}",
                      style: TextStyle(
                        color: order['status'] == 'Pending'
                            ? Colors.orange
                            : order['status'] == 'Shipped'
                            ? Colors.blue
                            : Colors.green,
                      ),
                    ),
                    Text("Total: \$${order['total']}"),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Confirm Delete"),
                            content: const Text(
                              "Are you sure you want to delete this order?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Perform delete logic here
                                  Navigator.pop(context);
                                },
                                child: const Text("Delete"),
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                              ),
                            ],
                          ),
                        );
                      },
<<<<<<< HEAD
                    ),
                  )
                ],
              ),
            ),
          );
        },
=======
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          orders[index]['status'] = 'Delivered';
                        });
                      },
                      icon: const Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // You can navigate to detailed order view here
                },
              ),
            );
          },
        ),
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
      ),
    );
  }
}
