import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomText.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/services/AuthService.dart';

class AssignedPatients extends StatelessWidget {
  const AssignedPatients({Key? key}) : super(key: key);
  Widget CustomText(data) {
    return H4Text(text: data);
  }

  @override
  Widget build(BuildContext context) {
    AuthService service = AuthService(FirebaseAuth.instance);
    User user = service.user;
    CollectionReference doctors =
        FirebaseFirestore.instance.collection('doctors');
    return FutureBuilder<DocumentSnapshot>(
      future: doctors.doc(user.phoneNumber).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data != null) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            List<dynamic> patients =
                data["patients"] ?? ["no patient assigned"];
            return Row(
                children: [for (var name in patients) Text(name.toString())]);
          }
        }

        return Text("loading");
      },
    );
  }
}
