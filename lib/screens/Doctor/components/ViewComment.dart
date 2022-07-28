import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CommentCard.dart';
import 'package:patient_app/components/CustomText.dart';
import 'package:patient_app/components/CustomTextButton.dart';
import 'package:patient_app/components/CustomTextField.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/services/AuthService.dart';
import 'package:patient_app/services/doctorUser.dart';
import 'package:patient_app/services/patientUser.dart';
import 'package:patient_app/utils/showSnackBar.dart';

class ViewComments extends StatefulWidget {
  final String id;
  ViewComments({Key? key, required this.id}) : super(key: key);

  @override
  State<ViewComments> createState() => _ViewCommentsState(this.id);
}

class _ViewCommentsState extends State<ViewComments> {
  final String id;
  _ViewCommentsState(this.id);
  TextEditingController commentController = TextEditingController();
  DoctorUser docService = DoctorUser();
  final _formKey = GlobalKey<FormState>();
  void removeItem(int index, List comments) async {
    AuthService auth = AuthService(FirebaseAuth.instance);
    User user = auth.user;
    if (comments[index]["docId"] != user.phoneNumber) {
      showSnackBar(context, "Comment cannot be removed");
      return;
    }
    PatientUser service = PatientUser();
    comments = List.from(comments)..removeAt(index);
    await service.removeComments(comments, widget.id);
    showSnackBar(context, "comment removed");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference patients =
        FirebaseFirestore.instance.collection('patients');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                        List<dynamic> comments = [];
                        String patname = "";
                        if (data.isNotEmpty) {
                          comments = ((data['comments'] ?? []) as List);
                          patname = data["name"];
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
                                Text(patname,
                                    style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: kh3FontWeight)),
                                SizedBox.shrink()
                              ],
                            ),
                            SizedBox(height: 30),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.55,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child:
                                    // Column(
                                    //   children: comments
                                    //       .map((comment) => CommentCard(
                                    //           comment: comment["comment"],
                                    //           docId: comment["byDoc"],
                                    //           onDelete: () => null))
                                    //       .toList(),
                                    // )
                                    Column(children: [
                                  for (int i = 0; i < comments.length; i++)
                                    CommentCard(
                                        comment:
                                            comments[i]["comment"].toString(),
                                        docId: comments[i]["byDoc"].toString(),
                                        onDelete: () =>
                                            removeItem(i, comments)),
                                ]),
                              ),
                            ),
                          ],
                        );
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
                            Text("Add Comment",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: kh3FontWeight)),
                            SizedBox.shrink()
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 10),
                      Form(
                        key: _formKey,
                        child: Container(
                          child: CustomTextField(
                              controller: commentController,
                              hintText: "add comment"),
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomTextButton(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await docService.addCommentToPatient(
                                  "${commentController.text}", id);
                              showSnackBar(context, "comment added");

                              // DocumentSnapshot<Object?> data =
                              //     await docService.getDoctor();
                              // log(data.data().toString());
                            }
                          },
                          fullWidth: true,
                          label: "Save",
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
