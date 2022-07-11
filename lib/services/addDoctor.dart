import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDoctor {
  final String name;
  final String gender;
  final int age;
  final String qualifications;
  final String departments;
  late DocumentReference doc;

  AddDoctor(
      {required this.name,
      required this.gender,
      required this.age,
      required this.qualifications,
      required this.departments}) {
    getUser();
  }

  void getUser() {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        doc = FirebaseFirestore.instance
            .collection('doctors')
            .doc(user.phoneNumber);
        return await addDoc();
      }
    });
  }

  // DocumentReference doc =
  //     FirebaseFirestore.instance.collection('doctors').doc("arihant");

  // Future<void> addDoc() {
  //   // Call the user's CollectionReference to add a new user
  //   if (doc == null) return Future<String>.value('user is null');
  //   return doc
  //       .set({
  //         'name': name, // John Doe
  //         'gender': gender, // Stokes and Sons
  //         'age': age, // 42,
  //         'departments': departments,
  //         'qualifications': qualifications
  //       })
  //       .then((value) => {print("User Added")})
  //       .catchError((error) => print("Failed to add user: $error"));
  // }

  Future<void> addDoc() {
    // Call the user's CollectionReference to add a new user
    return doc
        .set({
          'name': name, // John Doe
          'gender': gender, // Stokes and Sons
          'age': age, // 42,
          'departments': departments,
          'qualifications': qualifications
        })
        .then((value) => {print("User Added")})
        .catchError((error) => print("Failed to add user: $error"));
  }
}
