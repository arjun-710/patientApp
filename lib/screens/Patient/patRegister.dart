import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomTextButton.dart';
import 'package:patient_app/components/CustomTextField.dart';
import 'package:patient_app/constants.dart';
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
    // auth.signOut();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(kLogo),
                  const SizedBox(height: 40.0),
                  const Text(
                    'Enter patient details',
                    style: TextStyle(
                        fontWeight: kh1FontWeight,
                        fontSize: kh4size,
                        fontFamily: 'Montserrat'),
                  ),
                  const SizedBox(height: 40.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: "Full Name",
                          controller: nameController,
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextField(
                          hintText: "Gender",
                          controller: genderController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            } else if (value == "male" || value == "female") {
                              return null;
                            }
                            return "Enter male or female";
                          },
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextField(
                          keyType: TextInputType.number,
                          hintText: "Age",
                          controller: ageController,
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextField(
                          keyType: TextInputType.number,
                          hintText: "Ward",
                          controller: wardController,
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextField(
                          keyType: TextInputType.number,
                          hintText: "Room number",
                          controller: roomNumController,
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextField(
                          keyType: TextInputType.number,
                          hintText: "Bed Number",
                          controller: bedNumNumController,
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextButton(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('User Registered'),
                                  ),
                                );
                                addPat = AddPatient(
                                  name: nameController.text,
                                  gender: genderController.text,
                                  age: int.parse(ageController.text),
                                  ward: wardController.text,
                                  roomNum: roomNumController.text,
                                  bedNum: bedNumNumController.text,
                                );
                                Navigator.pushNamed(context, '/PatLanding');
                              }
                            },
                            label: "Submit")
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
