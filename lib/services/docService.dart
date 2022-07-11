// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DocService {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference doc = FirebaseFirestore.instance.collection('doctors');
}
