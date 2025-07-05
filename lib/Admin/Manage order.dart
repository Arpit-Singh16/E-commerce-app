import 'package:flutter/material.dart';

class ManageOrder extends StatefulWidget {
  const ManageOrder({super.key});

  @override
  State<ManageOrder> createState() => _ManageOrderState();
}

class _ManageOrderState extends State<ManageOrder> {
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
                              ),
                            ],
                          ),
                        );
                      },
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
      ),
    );
  }
}
