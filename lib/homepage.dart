import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Cart_page.dart';
import 'Customized/Custom_homepage_cards.dart';
import 'Customized/Customizedbuttons.dart';
import 'Customized/card_with_assetimage.dart';
import 'Customized/card_with_networkimage.dart';
import 'notificationpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {


  // var products= FirebaseFirestore.instance.collection('products').get();
  // Map<String, dynamic> List = products as Map<String, dynamic>;



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          elevation: 0,
          title: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search for products...",
                hintStyle: TextStyle(color: Colors.grey[700]),
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.camera_alt),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          actions: [
            CustomIconButton(
              icon: Icons.notifications,
              page: const Notification_page(),
            ),
          ],
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Greeting
            Container(
              color: Colors.black,
              height: 50,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                "Welcome Back 👋",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Scrollable main content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 🔥 Banner
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        height: 160,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.deepPurpleAccent, Colors.indigo],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "iPhone 16 Pro",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Beyond Innovation",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              child: Image.network(
                                "https://www.apple.com/newsroom/images/product/iphone/standard/Apple_iPhone-14-Pro_iPhone-14-Lineup_220907_inline.jpg.large.jpg",
                                width: 120,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // 📦 Categories
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: const [
                          Card_asset(
                            text: "Mobile",
                            image: "assets/images/phone.png",
                          ),
                          Card_asset(
                            text: "Headphone",
                            image: "assets/images/IMG-20250702-WA0002.jpg",
                          ),
                          Card_asset(
                            text: "Laptop",
                            image: "assets/images/IMG-20250702-WA0003.jpg",
                          ),
                          Card_asset(
                            text: "Clothes",
                            image: "assets/images/IMG-20250702-WA0004.jpg",
                          ),
                          Card_asset(
                            text: "Speaker",
                            image: "assets/images/IMG-20250702-WA0005.jpg",
                          ),
                          Card_asset(
                            text: "More",
                            image: "assets/images/IMG-20250702-WA0005.jpg",
                          ),
                        ],
                      ),
                    ),

                    // 💥 Flash Deals
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Flash Deals for You",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "See All",
                            style: TextStyle(color: Colors.deepPurple),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: const [
                          Horizontal_card(
                            text: 'Smart Watch',
                            image: 'assets/images/IMG-20250702-WA0003.jpg',
                          ),
                          Horizontal_card(
                            text: 'Bluetooth Speaker',
                            image: 'assets/images/IMG-20250702-WA0002.jpg',
                          ),
                          Horizontal_card(
                            text: 'Gaming Mouse',
                            image: 'assets/images/IMG-20250702-WA0003.jpg',
                          ),
                          Horizontal_card(
                            text: 'Earbuds',
                            image: 'assets/images/IMG-20250702-WA0004.jpg',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: GridView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,

                        ),
                        children: [
                              CustomHomepageCards(),
                              CustomHomepageCards(),
                              CustomHomepageCards(),
                              CustomHomepageCards(),
                              CustomHomepageCards(),
                              CustomHomepageCards(),
                              CustomHomepageCards(),
                              CustomHomepageCards(),
                              CustomHomepageCards(),
                            ],
                          ),

                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
