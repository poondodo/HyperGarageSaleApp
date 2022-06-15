import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class FirestoreService {
  static List instance = [];
  static Future<List> readAll() async {
    try {
      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection('chun & zhu sale post list');
      QuerySnapshot querySnapshot = await _collectionRef.get();
      instance = querySnapshot.docs;

    } on firebase_core.FirebaseException catch (e) {
      print('following are firebase_core.FirebaseException: ');
      print(e);
    }

    final documents = await instance;

    return documents;
  }
}
