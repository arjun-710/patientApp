import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomTextButton.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/main.dart';
import 'package:patient_app/screens/Patient/components/AddRecord.dart';
import 'package:patient_app/services/patientUser.dart';
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

  @override
  Widget build(BuildContext context) {
    CollectionReference patients =
        FirebaseFirestore.instance.collection('patients');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<DocumentSnapshot>(
                future: patients.doc(widget.id).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                      List<dynamic> records = data['records'] ?? ["no records"];
                      return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                                children: records.map((value) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 40, horizontal: 30),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: k3Color,
                                          borderRadius: BorderRadius.circular(
                                              kBorderRadius)),
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: SvgPicture.asset(kJpg)),
                                          SizedBox(width: 20),
                                          Text(value["name"]),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20)
                                ],
                              );
                              //Return an empty Container for non-matching case
                            }).toList()),
                          ));
                    }
                  }

                  return Text("loading");
                },
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SvgPicture.asset(kLeft),
                          Text("Add New Record",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: kh3FontWeight)),
                          SizedBox.shrink()
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    SizedBox(height: 20),
                    CustomTextButton(
                        onTap: () async {
                          // log('going in');
                          // await docService.addCommentToPatient(
                          //     "${commentController.text}", id);
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
                        label: "Save new Record",
                        children: SvgPicture.asset(kAdd))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
