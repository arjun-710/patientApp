import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomTextButton.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Patient/components/AddRecord.dart';
import 'package:patient_app/utils/colors_util.dart';
import 'package:patient_app/utils/showSnackBar.dart';

class ViewRecords extends StatefulWidget {
  final String? id;
  const ViewRecords({Key? key, required this.id}) : super(key: key);

  @override
  State<ViewRecords> createState() => _ViewRecordsState(this.id);
}

class _ViewRecordsState extends State<ViewRecords> {
  final String? id;
  _ViewRecordsState(this.id);
  var dio = Dio();

  @override
  Widget build(BuildContext context) {
    CollectionReference patients =
        FirebaseFirestore.instance.collection('patients');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Medical Records",
                          style: TextStyle(
                              fontSize: 28, fontWeight: kh3FontWeight)),
                    ],
                  ),
                ),
                FutureBuilder<DocumentSnapshot>(
                  future: patients.doc(widget.id).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text("Something went wrong"));
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return Center(child: Text("Document does not exist"));
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData && snapshot.data != null) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        List<dynamic> records = [];
                        if (data.isNotEmpty) {
                          records = ((data['records'] ?? []) as List);
                        }
                        return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.60,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                  children: records.map((value) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        showSnackBar(context,
                                            "${value["name"]} downloaded");
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: HexColor("FEECE2"),
                                            borderRadius: BorderRadius.circular(
                                                kBorderRadius)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 25),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              KfileDoc,
                                              width: 24,
                                              height: 30,
                                            ),
                                            SizedBox(width: 20),
                                            Flexible(
                                              child: RichText(
                                                overflow: TextOverflow.ellipsis,
                                                strutStyle:
                                                    StrutStyle(fontSize: 12.0),
                                                text: TextSpan(
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    text: value["name"]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10)
                                  ],
                                );
                                //Return an empty Container for non-matching case
                              }).toList()),
                            ));
                      }
                    }

                    return CircularProgressIndicator();
                  },
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      CustomTextButton(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddRecord(
                                  patId: id,
                                ),
                              ),
                            );
                          },
                          fullWidth: true,
                          label: "Add file",
                          children: SvgPicture.asset(kAdd))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
