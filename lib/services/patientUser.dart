import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:patient_app/services/AuthService.dart';
import 'package:patient_app/services/doctorUser.dart';

class Comment {
  final String comment;
  final String byDoc;

  Comment({
    required this.comment,
    required this.byDoc,
  });

  Map<String, dynamic> toJson() => {
        'comment': comment,
        'byDoc': byDoc,
      };
}

class PatientUser {
  String? name;
  int? age;
  String? gender;
  String? roomNum;
  String? ward;
  String? phoneNum;
  String? bedNum;
  List<Comment>? comments;
  Timestamp? createdAt;
  PatientUser(
      {this.name,
      this.gender,
      this.age,
      this.ward,
      this.roomNum,
      this.bedNum,
      this.phoneNum,
      this.createdAt});

  final FirebaseFirestore db = FirebaseFirestore.instance;

  PatientUser.fromMap(Map<String, dynamic>? data) {
    name = data?['name'];
    age = data?['age'];
    gender = data?['gender'];
    roomNum = data?['roomNum'];
    ward = data?['ward'];
    bedNum = data?['bedNum'];
    phoneNum = data?['phoneNum'];
    comments = data?['patients']?.map((comment) => comment.toMap()).toList();
    createdAt = data?['createdAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'roomNum': roomNum,
      'ward': ward,
      'bedNum': bedNum,
      'phoneNum': phoneNum,
      'comments': comments?.map((comment) => comment).toList(),
      'createdAt': createdAt
    };
  }

  checkPatExists(String phoneNumber) async {
    try {
      DocumentReference doc =
          FirebaseFirestore.instance.collection('patients').doc(phoneNumber);

      return await doc.get();
    } catch (e) {
      throw e;
    }
  }

  addPatient(PatientUser patData) async {
    AuthService service = AuthService(FirebaseAuth.instance);
    User user = service.user;
    patData.phoneNum = user.phoneNumber;
    patData.createdAt = Timestamp.now();
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
    AuthService service = AuthService(FirebaseAuth.instance);
    User user = service.user;
    await db
        .collection("patients")
        .doc(user.phoneNumber)
        .update(patData.toMap());
  }

  removePrescription(List medicines, String patId) async {
    AuthService service = AuthService(FirebaseAuth.instance);
    User user = service.user;
    String prescriptionId = "${user.phoneNumber}${patId}";

    // Medicine med = Medicine(
    //     medName: medName,
    //     quantity: int.parse(quantity),
    //     frequency: int.parse(frequency));
    await db
        .collection("prescriptions")
        .doc(prescriptionId)
        .set({"medicines": medicines});
  }

  addPrescription(
      String medName, int quantity, int frequency, String patId) async {
    AuthService service = AuthService(FirebaseAuth.instance);
    User user = service.user;
    String prescriptionId = "${user.phoneNumber}${patId}";

    Medicine med = Medicine(
      frequency: frequency,
      medName: medName,
      quantity: quantity,
    );
    await db.collection("patients").doc(patId).update(
      {
        "prescriptions": FieldValue.arrayUnion([prescriptionId])
      },
    );
    await db.collection("prescriptions").doc(prescriptionId).set({
      "medicines": FieldValue.arrayUnion([med.toJson()])
    }, SetOptions(merge: true));
  }

  Future<void> deletePatients() async {
    AuthService service = AuthService(FirebaseAuth.instance);
    User user = service.user;
    await db.collection("patients").doc(user.phoneNumber).delete();
  }
}
