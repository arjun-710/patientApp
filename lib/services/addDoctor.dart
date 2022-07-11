import 'dart:developer';

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

  AddDoctor(
      {required this.name,
      required this.gender,
      required this.age,
      required this.qualifications,
      required this.departments});

  CollectionReference doc = FirebaseFirestore.instance.collection('doctors');

  Future<void> addDoc() {
    // Call the user's CollectionReference to add a new user
    return doc
        .add({
          'name': name, // John Doe
          'gender': gender, // Stokes and Sons
          'age': age, // 42,
          'departments': departments,
          'qualifications': qualifications
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
