import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomText.dart';
import 'package:patient_app/components/CustomTextButton.dart';
import 'package:patient_app/components/phoneNumberTextField.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/services/AuthService.dart';
import 'package:patient_app/services/doctorUser.dart';
import 'package:patient_app/services/patientUser.dart';
import 'package:patient_app/utils/showSnackBar.dart';

class AddPatient extends StatefulWidget {
  const AddPatient({Key? key}) : super(key: key);

  @override
  State<AddPatient> createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController regionController = TextEditingController(text: "91");
  final _formKey = GlobalKey<FormState>();
  PatientUser patService = PatientUser();
  DoctorUser docService = DoctorUser();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(kLeft),
                    Text("Add Patient",
                        style:
                            TextStyle(fontSize: 32, fontWeight: kh3FontWeight)),
                    SizedBox.shrink()
                  ],
                ),
              ),
              const SizedBox(height: 30),
              H3Text(
                text: "Enter patient's phone Number",
                weight: kh3FontWeight,
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: PhoneNumberTextField(
                    regionController: regionController,
                    phoneController: phoneController),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 1.75),
              CustomTextButton(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      DocumentSnapshot ds = await FirebaseFirestore.instance
                          .collection("patients")
                          .doc(
                              "+${regionController.text}${phoneController.text}")
                          .get();
                      Map<String, dynamic> data =
                          ds.data() as Map<String, dynamic>;

                      if (ds.exists) {
                        AuthService service =
                            AuthService(FirebaseAuth.instance);
                        User user = service.user;
                        FirebaseFirestore firebase = FirebaseFirestore.instance;
                        firebase
                            .collection("doctors")
                            .doc(user
                                .phoneNumber) // Document which contains the products array
                            .get()
                            .then((doc) async {
                          var patDat = (doc.data()?['patients'] ?? []) as List;
                          if (patDat.length > 0) {
                            var prodList = doc
                                .data()?["patients"]
                                .where(
                                    (x) => // Traversing the data of the document to the products array
                                        x?["patId"] ==
                                        "+${regionController.text}${phoneController.text}" // Predicate to filter the array by
                                    )
                                .toList();

                            if (prodList.length > 0) {
                              showSnackBar(
                                  context, "patient is already assigned");
                            } else {
                              await docService.addPatientToDoctor(
                                  "+${regionController.text}${phoneController.text}",
                                  data["name"] as String);
                              showSnackBar(context, "patient added");
                            }
                          } else {
                            await docService.addPatientToDoctor(
                                "+${regionController.text}${phoneController.text}",
                                data["name"] as String);
                            showSnackBar(context, "patient added");
                          }
                        });
                      } else {
                        showSnackBar(context, "pat does not exists");
                      }
                    }
                  },
                  fullWidth: true,
                  label: "Save",
                  children: SvgPicture.asset(kAdd))
            ],
          ),
        ),
      )),
    );
  }
}
