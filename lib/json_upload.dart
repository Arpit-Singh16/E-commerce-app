import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  void initState() {
    super.initState();
    uploadJsonToFirestore(); // ⬅️ Call the function here
  }

  Future<void> uploadJsonToFirestore() async {
    try {
      String jsonString = await rootBundle.loadString('assets/products_with_realistic_prices.json');
      List<dynamic> jsonList = json.decode(jsonString); // 🔁 Parse as list

      CollectionReference productsRef = FirebaseFirestore.instance.collection('products');

      for (int i = 0; i < jsonList.length; i++) {
        var docData = jsonList[i];
        String docId = 'product_$i'; // Or use a field like `docData['id']`

        await productsRef.doc(docId).set(docData);
        print('✅ Uploaded $docId');
      }

      print('🎉 All data uploaded successfully!');
    } catch (e) {
      print('❌ Error uploading: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload JSON')),
      body: Center(
        child: Text('Uploading JSON to Firestore...'),
      ),
    );
  }
}
