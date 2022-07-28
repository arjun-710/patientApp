import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:patient_app/components/BookTap.dart';
import 'package:patient_app/components/CustomText.dart';
import 'package:patient_app/components/Greetings.dart';
import 'package:patient_app/components/InfoCard.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Doctor/components/PatList.dart';
import 'package:patient_app/screens/Doctor/components/docProfile.dart';
import 'package:patient_app/screens/Doctor/docLogin.dart';
import 'package:patient_app/services/AuthService.dart';
import 'package:patient_app/services/doctorUser.dart';
import 'package:provider/provider.dart';

class PatDetails extends StatelessWidget {
  final String ward;
  final String roomNum;
  final String bedNum;
  const PatDetails(
      {Key? key,
      required this.ward,
      required this.roomNum,
      required this.bedNum})
      : super(key: key);

  Text CustomText(data) {
    return Text(data,
        style: const TextStyle(fontSize: kh4size, color: kStrokeColor));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(kBed),
        SizedBox(width: 10),
        CustomText(ward),
        CustomText(" | "),
        CustomText(roomNum),
        CustomText(" | "),
        CustomText(bedNum)
      ],
    );
  }
}

class DocHome extends StatelessWidget {
  const DocHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    DoctorUser service = DoctorUser();
    late final Future<Object>? future = service.getDoctor();

    return StreamBuilder<User?>(
        stream: authService.authState,
        builder: (_, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            return user == null
                ? const DocLogin()
                : SafeArea(
                    child: FutureBuilder<Object>(
                        future: future,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Error');
                          }
                          if (snapshot.hasData) {
                            if (!snapshot.data!.exists) {
                              return const Text('Document not found');
                            } else {
                              return doctorHome(
                                name: snapshot.data["name"] ?? "",
                                gender: snapshot.data["gender"] ?? "",
                                age: snapshot.data["age"] ?? "",
                                qualification:
                                    snapshot.data["qualification"] ?? "",
                                department: snapshot.data["department"] ?? "",
                                patients: snapshot.data["patients"] ?? "",
                              );
                            }
                          }
                          // if (snapshot.hasData) {
                          //   return doctorHome(
                          //     name: snapshot.data["name"],
                          //     gender: snapshot.data["gender"],
                          //     age: snapshot.data["age"],
                          //     qualification: snapshot.data["qualification"],
                          //     department: snapshot.data["department"],
                          //     patients: snapshot.data["patients"],
                          //   );
                          // }
                          else
                            return Scaffold(
                              body: Center(child: CircularProgressIndicator()),
                            );
                        }),
                  );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

class doctorHome extends StatelessWidget {
  final String name;
  final int age;
  final String gender;
  final String qualification;
  final String department;
  final List patients;
  const doctorHome({
    Key? key,
    required this.name,
    required this.age,
    required this.gender,
    required this.qualification,
    required this.department,
    required this.patients,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
          child: Column(
            children: [
              Greetings(
                greet: "Good morning,",
                personName: name,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DocProfile()),
                  );
                },
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  if (patients.length > 0) ...[
                    SizedBox(
                        height: 300, child: myInfo_card(patients: patients)),
                  ] else
                    ...[]
                ],
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  H3Text(
                    text: "All Patients Admitted",
                    weight: kh3FontWeight,
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 2.75,
                      child: PatList(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class myInfo_card extends StatefulWidget {
  final List patients;
  const myInfo_card({Key? key, required this.patients}) : super(key: key);

  @override
  State<myInfo_card> createState() => _myInfo_cardState(patients);
}

class _myInfo_cardState extends State<myInfo_card> {
  List patients;
  _myInfo_cardState(this.patients);
  @override
  void initState() {
    super.initState();
    patients = patients.map((e) => e["patId"]).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: patients
              .map((e) => Column(
                    children: [
                      Container(
                          child: StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('patients')
                                  .doc(e)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasData && snapshot.data != null) {
                                  var data = snapshot.data;

                                  return InfoCard(
                                    posType: "${data!["ward"]} patient",
                                    name: "${data["name"]}",
                                    // nextVisit: "Next visit at 4pm",
                                    age: "${data["age"].toString()}",
                                    gender: "${data["gender"]}",
                                    svgPath: kEmergencyWard,
                                    child: PatDetails(
                                      ward: data["ward"],
                                      roomNum: data["roomNum"],
                                      bedNum: data["bedNum"],
                                    ),
                                  );
                                }
                                //this will load first
                                return CircularProgressIndicator();
                              })),
                      SizedBox(height: 20),
                    ],
                  ))
              .toList()),
    );
  }
}
