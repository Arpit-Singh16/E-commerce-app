import 'package:flutter/material.dart';
import 'package:quotetowallpaper/Admin/AdminOrder.dart';
import 'package:quotetowallpaper/Admin/AdminProducts.dart';
import 'package:quotetowallpaper/Admin/AdminProfile.dart';
import 'package:quotetowallpaper/Admin/AdminUsers.dart';

class Adminpage extends StatefulWidget {
  const Adminpage({super.key});

  @override
  State<Adminpage> createState() => _AdminpageState();
}

class _AdminpageState extends State<Adminpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text('Admin', style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Colors.black, // Dark AppBar
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Hello Admin",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  _buildAdminListTile(
                    context,
                    'Manage Orders',
                    Icons.shopping_cart,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Adminorder()),
                      );
                    },
                  ),
                  _buildAdminListTile(context, 'Manage Products', Icons.fastfood, () {
                    Navigator.push(
                      context,
<<<<<<< HEAD
                      MaterialPageRoute(builder: (context) => AdminProducts()),
=======
                      MaterialPageRoute(builder: (context) => Adminproducts()),
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                    );
                  }),
                  _buildAdminListTile(context, 'Manage Users', Icons.people, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Adminusers()),
                    );
                  }),
                  _buildAdminListTile(context, 'Profile', Icons.person, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminProfile()),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminListTile(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      // Optional: Wrap ListTile in a Card for elevation and styling
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(title, style: TextStyle(fontSize: 18.0)),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
