import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_app/components/appBar.dart';
import 'package:patient_app/services/addDoctor.dart';
import 'package:patient_app/services/addPatient.dart';

class PatRegister extends StatefulWidget {
  const PatRegister({Key? key}) : super(key: key);

  @override
  State<PatRegister> createState() => _PatRegisterState();
}

class _PatRegisterState extends State<PatRegister> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController wardController = TextEditingController();
  TextEditingController roomNumController = TextEditingController();
  TextEditingController bedNumNumController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AddPatient? addPat;

  Future<bool> checkIfPatExists(User user) async {
    try {
      // Get reference to Firestore collection
      DocumentReference doc = FirebaseFirestore.instance
          .collection('patients')
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
        checkIfPatExists(user).then((value) => {
              if (value) {Navigator.pushNamed(context, '/PatLanding')}
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(label: "Patient").appBar(),
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
              label: "ward",
              currController: wardController,
            ),
            InputField(
              label: "roomNum",
              currController: roomNumController,
            ),
            InputField(
              label: "bedNum",
              currController: bedNumNumController,
            ),
            TextButton(
                onPressed: () {
                  addPat = AddPatient(
                    name: nameController.text,
                    gender: genderController.text,
                    age: int.parse(ageController.text),
                    ward: wardController.text,
                    roomNum: roomNumController.text,
                    bedNum: bedNumNumController.text,
                  );
                  Navigator.pushNamed(context, '/PatLanding');
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
  const InputField(
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
