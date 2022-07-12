import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_app/components/appBar.dart';
import 'package:patient_app/services/addDoctor.dart';

class PatRegister extends StatefulWidget {
  const PatRegister({Key? key}) : super(key: key);

  @override
  State<PatRegister> createState() => _PatRegisterState();
}

class _PatRegisterState extends State<PatRegister> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AddDoctor? addDoc;

  Future<bool> checkIfDocExists(User user) async {
    try {
      // Get reference to Firestore collection
      DocumentReference doc = FirebaseFirestore.instance
          .collection('doctors')
          .doc(user.phoneNumber);

      var getDoc = await doc.get();
      return getDoc.exists;
    } catch (e) {
      throw e;
    }
  }

  @override
  void initState() {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushNamed(context, '/PatLogin');
      } else {
        checkIfDocExists(user).then((value) => {
              if (value) {Navigator.pushNamed(context, '/DocLanding')}
            });
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
                  addDoc = AddDoctor(
                    name: nameController.text,
                    gender: genderController.text,
                    age: int.parse(ageController.text),
                    qualifications: qualificationController.text,
                    departments: departmentController.text,
                  );
                  Navigator.pushNamed(context, '/DocLanding');
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
