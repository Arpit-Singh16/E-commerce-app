import 'package:flutter/material.dart';
import 'package:quotetowallpaper/update_profile.dart';
import 'Aboutus.dart';
import 'Customercare.dart';
import 'Customized/custome_profilelist.dart';

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
          CustomeProfilelist(title: 'Profile', page: Profile() ),
          CustomeProfilelist(title: 'Your order', page: Profile() ),
          CustomeProfilelist(title: 'Customer Service', page: CustomerCarePage() ),
          CustomeProfilelist(title: 'About us', page: AboutUsPage() ),
        ],
      ),
    );
  }
}
