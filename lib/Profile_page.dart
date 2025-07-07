import 'package:flutter/material.dart';
import 'package:quotetowallpaper/update_profile.dart';
import 'Aboutus.dart';
import 'Customercare.dart';
import 'Customized/custome_profilelist.dart';
<<<<<<< HEAD
import 'Your_order.dart';
=======
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title:Text("Profile",style: TextStyle(color: Colors.white),) ,
      ),
      body: Column(
        children: [
<<<<<<< HEAD
          CustomeProfilelist(title: 'Profile',  onTap:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));}, icon: Icons.person, ),
          CustomeProfilelist(title: 'Your order', onTap:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>YourOrder()));}, icon: Icons.shopping_cart, ),
          CustomeProfilelist(title: 'About us',  onTap:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUsPage()));}, icon: Icons.help_outline, ),
=======
          CustomeProfilelist(title: 'Profile', page: Profile() ),
          CustomeProfilelist(title: 'Your order', page: Profile() ),
          CustomeProfilelist(title: 'Customer Service', page: CustomerCarePage() ),
          CustomeProfilelist(title: 'About us', page: AboutUsPage() ),
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
        ],
      ),
    );
  }
}
