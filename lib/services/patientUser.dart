import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:patient_app/services/AuthService.dart';

class PatientUser {
  String? name;
  int? age;
  String? gender;
  String? roomNum;
  String? ward;
  String? phoneNum;
  String? bedNum;
  PatientUser(
      {this.name,
      this.gender,
      this.age,
      this.ward,
      this.roomNum,
      this.bedNum,
      this.phoneNum});

  final FirebaseFirestore db = FirebaseFirestore.instance;

  PatientUser.fromMap(Map<String, dynamic>? data) {
    name = data?['name'];
    age = data?['age'];
    gender = data?['gender'];
    roomNum = data?['roomNum'];
    ward = data?['ward'];
    bedNum = data?['bedNum'];
    phoneNum = data?['phoneNum'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'roomNum': roomNum,
      'ward': ward,
      'bedNum': bedNum,
      'phoneNum': phoneNum
    };
  }

  Future<bool> checkPatExists(String phoneNumber) async {
    try {
      // Get reference to Firestore collection
      DocumentReference doc =
          FirebaseFirestore.instance.collection('patients').doc(phoneNumber);

      var getDoc = await doc.get();
      return getDoc.exists;
    } catch (e) {
      throw e;
    }
  }

  addPatient(PatientUser patData) async {
    AuthService service = AuthService(FirebaseAuth.instance);
    User user = service.user;
    patData.phoneNum = user.phoneNumber;

    try {
      await db
          .collection("patients")
          .doc(user.phoneNumber)
          .set(patData.toMap());
    } catch (e) {
      throw e;
    }
  }

  Future<DocumentSnapshot<Object?>> getPatient() async {
    AuthService service = AuthService(FirebaseAuth.instance);
    User user = service.user;
    DocumentSnapshot snapshot =
        await db.collection("patients").doc(user.phoneNumber).get();
    return snapshot;
  }

  updatePatient(PatientUser patData) async {
    log("update Patient method");
    AuthService service = AuthService(FirebaseAuth.instance);
    User user = service.user;
    await db
        .collection("patients")
        .doc(user.phoneNumber)
        .update(patData.toMap());
  }

  Future<void> deletePatients() async {
    AuthService service = AuthService(FirebaseAuth.instance);
    User user = service.user;
    await db.collection("patients").doc(user.phoneNumber).delete();
  }

  PatientUser.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : name = doc.data()!["name"],
        age = doc.data()!["age"],
        gender = doc.data()!["gender"],
        roomNum = doc.data()!["roomNum"],
        ward = doc.data()!["ward"],
        bedNum = doc.data()!["bedNum"],
        phoneNum = doc.data()!["phoneNum"];

  Future<List<PatientUser>> getPatients() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("patients").get();
    return snapshot.docs
        .map((docSnapshot) => PatientUser.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}
