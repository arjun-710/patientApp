import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomText.dart';
import 'package:patient_app/components/CustomTextButton.dart';
import 'package:patient_app/components/phoneNumberTextField.dart';
import 'package:patient_app/constants.dart';
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
                      await docService.addPatientToDoctor(
                          "+${regionController.text}${phoneController.text}");
                      showSnackBar(context, "patient added");

                      DocumentSnapshot<Object?> data =
                          await docService.getDoctor();
                      log(data.data().toString());
                    }
                    bool didPat = await patService.checkPatExists(
                        "+${regionController.text}${phoneController.text}");
                    if (didPat) {
                      log("pat exist");
                    } else {
                      showSnackBar(context, "Patient does not exist");
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
