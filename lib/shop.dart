import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;

final firestore = FirebaseFirestore.instance;

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  getData() async {
    try {
      await auth.signInWithEmailAndPassword(
          email: "kim@test.com", password: "123456");
    } catch (e) {
      print(e);
    }
    if (auth.currentUser?.uid == null) {
      print('no login');
    } else {
      print('yes login');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Text('shop'));
  }
}
