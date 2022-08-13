import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreHelper {
  final String collectionName = 'categories';
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  isertDummyDataInFirestore() async {
    firebaseFirestore.collection(collectionName).add({
      "nameAr": "طعام",
      "nameEn": "Food",
      "imageUrl":
          "https://yt3.ggpht.com/yti/AJo0G0kOqV6R1PORt5Bdd_7D27kUd5YNa_BgwmtM59rInw=s88-c-k-c0x00ffffff-no-rj-mo",
    });
  }

  addUserToFirestore(
      {String? userName,
      String? email,
      String? id,
      String? phone,
      String? country,
      String? city}) {
    FirebaseFirestore.instance.collection('user').doc(id).set({
      'userName': userName,
      'email': email,
      'id': id,
      'phone': phone,
      'country': country,
      'city': city
    });
  }

  getUserFromFirestore(String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance.collection('user').doc(id).get();
    Map<String, dynamic>? dataMap = documentSnapshot.data();
  }
}
