import 'package:ecommerce/view/auth/firestore_helper.dart';
import 'package:flutter/material.dart';

class FireStoreProvider extends ChangeNotifier {
  insertNewCategory() {
    FirestoreHelper.firestoreHelper.isertDummyDataInFirestore();
  }
}
