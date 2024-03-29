import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomTextButton.dart';
import 'package:patient_app/components/CustomTextField.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/services/doctorUser.dart';
import 'package:patient_app/utils/showSnackBar.dart';

class DocRegister extends StatefulWidget {
  const DocRegister({Key? key}) : super(key: key);

  @override
  State<DocRegister> createState() => _DocRegisterState();
}

class _DocRegisterState extends State<DocRegister> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
        Navigator.pushNamed(context, '/docLogin');
      } else {
        checkIfDocExists(user).then((value) => {
              if (value) {Navigator.pushNamed(context, '/DocLanding')}
            });
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    DoctorUser service = DoctorUser();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(k3LogoSmall),
                  const SizedBox(height: 40.0),
                  const Text(
                    'Enter doctor\'s details',
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
                          hintText: "Qualification",
                          controller: qualificationController,
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextField(
                          hintText: "Department",
                          controller: departmentController,
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextButton(
                            children: SizedBox.shrink(),
                            color: k3Color,
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.

                                DoctorUser val = DoctorUser(
                                    name: nameController.text,
                                    gender: genderController.text,
                                    age: int.parse(ageController.text),
                                    qualification: qualificationController.text,
                                    department: departmentController.text);

                                await service.addDoctor(val);
                                showSnackBar(context, "Doctor Registered");
                                Navigator.pushNamed(context, '/DocLanding');
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
