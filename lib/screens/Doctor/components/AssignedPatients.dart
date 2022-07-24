import 'dart:convert';
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
            Map<String, dynamic>? data =
                snapshot.data!.data() as Map<String, dynamic>;
            List<dynamic> patients = [];
            if (data.isNotEmpty) {
              patients = ((data['patients'] ?? []) as List);
            }
            return ListView.separated(
              itemCount: patients.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) {
                var data = patients[index];
                return Container(
                  decoration: BoxDecoration(
                      color: kCream,
                      borderRadius: BorderRadius.circular(kBorderRadius)),
                  child: ListTile(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             Comment(id: document.id, data: data)));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kBorderRadius),
                    ),
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(kBorderRadius)),
                            child: SvgPicture.asset(kCheckUp))
                      ],
                    ),
                    minLeadingWidth: 20,
                    title: Padding(
                      padding: EdgeInsets.only(left: 5, bottom: 5),
                      child: H3Text(text: data["patName"]),
                    ),
                    subtitle: Row(
                      children: [
                        CustomText(data["patId"]),
                      ],
                    ),
                    trailing: SvgPicture.asset(kRight),
                  ),
                );

                //  ListTile(
                //   title: Text(patients[index]["patName"].toString()),
                // );
              },
            );
          }
        }

        return Text("loading");
      },
    );
  }
}
