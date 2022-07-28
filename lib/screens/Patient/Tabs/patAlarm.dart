import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomText.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/services/AuthService.dart';

class PatAlarm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService service = AuthService(FirebaseAuth.instance);
    User user = service.user;
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('prescriptions')
            .where("patientId", isEqualTo: user.phoneNumber)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              List medData = [];
              if (data.isNotEmpty) {
                medData = ((data['medicines'] ?? []) as List);
              }
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(kLeft)),
                      H3Text(text: "My Prescriptions"),
                      SizedBox.shrink()
                    ],
                  ),
                  SizedBox(height: 40),
                  Column(
                      children: medData.map((value) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                          decoration: BoxDecoration(
                              color: kCream,
                              borderRadius:
                                  BorderRadius.circular(kBorderRadius)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${value["medName"].toString()}"),
                              SizedBox(width: 20),
                              Text("${value["quantity"].toString()} units/ml"),
                              Text(
                                  "${value["frequency"].toString()} times/ day"),
                            ],
                          ),
                        ),
                        SizedBox(height: 20)
                      ],
                    );
                    //Return an empty Container for non-matching case
                  }).toList()),
                ],
              );
            }).toList(),
          );
        },
      ),
    )));
  }
}

class PatPrescription extends StatelessWidget {
  final List medData;
  final int index;
  const PatPrescription({
    Key? key,
    required this.medData,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kCream, borderRadius: BorderRadius.circular(kBorderRadius)),
      child: ListTile(
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
                    borderRadius: BorderRadius.circular(kBorderRadius)),
                child: SvgPicture.asset(kCheckUp))
          ],
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(left: 2, bottom: 2),
          child: Text(
            "${medData[index]?["quantity"].toString() ?? ""} units/ml",
          ),
        ),
        minLeadingWidth: 20,
        title: Padding(
          padding: EdgeInsets.only(left: 2, bottom: 2),
          child: Text(
            medData[index]?["medName"] ?? "",
          ),
        ),
        trailing: Text(
          "${medData[index]?["frequency"].toString() ?? ""} times/day",
        ),
      ),
    );
  }
}
