import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:patient_app/services/AuthService.dart';

class DoctorUser {
  String? name;
  int? age;
  String? gender;
  String? qualification;
  String? department;
  late AuthService service;
  DoctorUser(
      {this.name, this.gender, this.age, this.qualification, this.department}) {
    service = AuthService(FirebaseAuth.instance);
  }

  final FirebaseFirestore db = FirebaseFirestore.instance;

  DoctorUser.fromMap(Map<String, dynamic>? data) {
    name = data?['name'];
    age = data?['age'];
    gender = data?['gender'];
    qualification = data?['qualification'];
    department = data?['department'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'qualification': qualification,
      'department': department,
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

  addDoctor(DoctorUser patData) async {
    User user = service.user;
    try {
      await db.collection("doctors").doc(user.phoneNumber).set(patData.toMap());
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

  updateDoctor(DoctorUser patData) async {
    // AuthService service = AuthService(FirebaseAuth.instance);
    User user = service.user;
    await db
        .collection("doctors")
        .doc(user.phoneNumber)
        .update(patData.toMap());
  }

  Future<void> deleteDoctors() async {
    // AuthService service = AuthService(FirebaseAuth.instance);
    User user = service.user;
    await db.collection("doctors").doc(user.phoneNumber).delete();
  }

  DoctorUser.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : name = doc.data()!["name"],
        age = doc.data()!["age"],
        gender = doc.data()!["gender"],
        qualification = doc.data()!["qualification"],
        department = doc.data()!["department"];

  Future<List<DoctorUser>> getDoctors() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("doctors").get();
    return snapshot.docs
        .map((docSnapshot) => DoctorUser.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}
