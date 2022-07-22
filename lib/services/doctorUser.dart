import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:patient_app/services/AuthService.dart';
import 'package:patient_app/services/patientUser.dart';
// import 'package:patient_app/services/patientUser.dart';

class AssignPatient {
  final String patId;
  final bool isAssigned;

  AssignPatient({
    required this.patId,
    required this.isAssigned,
  });

  Map<String, dynamic> toJson() => {
        'patId': patId,
        'isAssigned': isAssigned,
      };
}

class DoctorUser {
  String? name;
  int? age;
  String? gender;
  String? qualification;
  String? department;
  late AuthService service;
  List<String>? patients;

  DoctorUser(
      {this.name,
      this.gender,
      this.age,
      this.qualification,
      this.department,
      this.patients}) {
    service = AuthService(FirebaseAuth.instance);
  }

  final FirebaseFirestore db = FirebaseFirestore.instance;

  DoctorUser.fromMap(Map<String, dynamic>? data) {
    name = data?['name'];
    age = data?['age'];
    gender = data?['gender'];
    qualification = data?['qualification'];
    department = data?['department'];
    patients = data?['patients']?.map((phone) => phone.toMap()).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'qualification': qualification,
      'department': department,
      "patients": patients?.map((phone) => phone).toList(),
    };
  }

  Future<bool> checkDocExists(User user) async {
    try {
      // Get reference to Firestore collection
      DocumentReference doc = FirebaseFirestore.instance
          .collection('doctors')
          .doc(user.phoneNumber);

      var getDoc = await doc.get();
      return getDoc.exists;
    } catch (e) {
      throw e;
    }
  }

  addDoctor(DoctorUser docData) async {
    User user = service.user;
    try {
      await db.collection("doctors").doc(user.phoneNumber).set(docData.toMap());
    } catch (e) {
      throw e;
    }
  }

  Future<DocumentSnapshot<Object?>> getDoctor() async {
    // AuthService service = AuthService(FirebaseAuth.instance);
    User user = service.user;
    DocumentSnapshot snapshot =
        await db.collection("doctors").doc(user.phoneNumber).get();
    return snapshot;
  }

  updateDoctor(DoctorUser docData) async {
    // AuthService service = AuthService(FirebaseAuth.instance);
    User user = service.user;
    await db
        .collection("doctors")
        .doc(user.phoneNumber)
        .update(docData.toMap());
  }

  addPatientToDoctor(String patId) async {
    User user = service.user;
    await db.collection("doctors").doc(user.phoneNumber).update({
      "patients": FieldValue.arrayUnion([patId])
    });
  }

  addCommentToPatient(String comment, String id) async {
    User user = service.user;
    log(comment);
    log(id);
    final Comment _comment =
        Comment(comment: comment, byDoc: user.phoneNumber.toString());
    await db.collection("patients").doc(id).update({
      "comments": FieldValue.arrayUnion([_comment.toJson()])
    });
  }

  Future<void> deleteDoctors() async {
    // AuthService service = AuthService(FirebaseAuth.instance);
    User user = service.user;
    await db.collection("doctors").doc(user.phoneNumber).delete();
  }
}
