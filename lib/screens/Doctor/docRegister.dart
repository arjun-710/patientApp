import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_app/components/appBar.dart';
import 'package:patient_app/services/addDoctor.dart';

class docRegister extends StatefulWidget {
  const docRegister({Key? key}) : super(key: key);

  @override
  State<docRegister> createState() => _docRegisterState();
}

class _docRegisterState extends State<docRegister> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AddDoctor? addDoc;
  @override
  void initState() {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar().appBar(),
      body: SafeArea(
        child: ListView(
          children: [
            InputField(
              label: "Name",
              currController: nameController,
            ),
            InputField(
              label: "Gender",
              currController: genderController,
            ),
            InputField(
              label: "Age",
              currController: ageController,
            ),
            InputField(
              label: "Qualifications",
              currController: qualificationController,
              keyboardType: TextInputType.multiline,
            ),
            InputField(
              label: "Department",
              currController: departmentController,
              keyboardType: TextInputType.multiline,
            ),
            TextButton(
                onPressed: () {
                  log("pressed");
                  addDoc = AddDoctor(
                    name: nameController.text,
                    gender: genderController.text,
                    age: int.parse(ageController.text),
                    qualifications: qualificationController.text,
                    departments: departmentController.text,
                  );
                  addDoc!.addDoc();
                },
                child: const Text('Submit'))
          ],
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController currController;
  final TextInputType keyboardType;
  InputField(
      {required this.label,
      required this.currController,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        keyboardType: keyboardType,
        maxLines: null,
        controller: currController,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
