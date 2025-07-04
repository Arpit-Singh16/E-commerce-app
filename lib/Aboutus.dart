import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isWideScreen ? 700 : double.infinity),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Who We Are',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Welcome to ShopNest — your go-to destination for everything from fashion to electronics! "
                      "Founded with a vision to deliver quality products at unbeatable prices, ShopNest is more than just an e-commerce platform — it's a lifestyle partner. "
                      "We serve thousands of happy customers across India with a promise of trust, fast delivery, and exceptional customer support.",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),

                const Text(
                  'Our Mission',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "To make online shopping effortless, reliable, and enjoyable for every Indian household by offering the best selection of products and a seamless user experience.",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),

                const Text(
                  'Why Choose Us?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const BulletList(items: [
                  'Wide range of categories and products',
                  'Fast and secure checkout',
                  '24/7 customer care support',
                  'Flexible return and refund policy',
                  'Exclusive deals and discounts',
                ]),
                const SizedBox(height: 24),

                const Text(
                  'Contact Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('📧 Email: contact@shopnest.com'),
                const Text('📞 Phone: +91-99999-88888'),
                const Text('🌐 Website: www.shopnest.com'),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> items;
  const BulletList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (item) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("• ", style: TextStyle(fontSize: 18)),
            Expanded(child: Text(item, style: const TextStyle(fontSize: 16))),
          ],
        ),
      )
          .toList(),
    );
  }
}
