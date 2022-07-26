import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomTextButton.dart';
import 'package:patient_app/components/CustomTextField.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/services/AuthService.dart';
import 'package:patient_app/services/patientUser.dart';
import 'package:patient_app/utils/showSnackBar.dart';

class PatProfile extends StatefulWidget {
  final String name;
  final int age;
  final String bedNum;
  final String gender;
  final String ward;
  final String roomNum;
  const PatProfile(
      {Key? key,
      required this.name,
      required this.age,
      required this.bedNum,
      required this.gender,
      required this.ward,
      required this.roomNum})
      : super(key: key);

  @override
  State<PatProfile> createState() =>
      _PatProfileState(name, age, bedNum, gender, ward, roomNum);
}

class _PatProfileState extends State<PatProfile> {
  final String name;
  final int age;
  final String bedNum;
  final String gender;
  final String ward;
  final String roomNum;
  _PatProfileState(
      this.name, this.age, this.bedNum, this.gender, this.ward, this.roomNum);
  bool canEdit = false;
  PatientUser service = PatientUser();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController wardController = TextEditingController();
  TextEditingController roomNumController = TextEditingController();
  TextEditingController bedNumController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = name;
    genderController.text = gender;
    ageController.text = age.toString();
    wardController.text = ward;
    roomNumController.text = roomNum;
    bedNumController.text = bedNum;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: isPortrait == true
                  ? MediaQuery.of(context).size.height - 40
                  : 0,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SvgPicture.asset(kLeft)),
                            SvgPicture.asset(kLogoUnnamed),
                            GestureDetector(
                                onTap: () {
                                  this.setState(() {
                                    canEdit = !canEdit;
                                  });
                                },
                                child: SvgPicture.asset(kEdit))
                          ],
                        ),
                        SizedBox(height: 30),
                        Text(
                          nameController.text,
                          style: TextStyle(fontSize: kh1Size),
                        ),
                        SizedBox(height: 40),
                        if (canEdit == true) ...[
                          CustomTextField(
                            controller: nameController,
                            hintText: "name",
                            readOnly: !canEdit,
                          ),
                          SizedBox(height: 20),
                        ] else ...[
                          SizedBox(height: 40),
                        ],
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: CustomTextField(
                                controller: genderController,
                                hintText: "gender",
                                readOnly: !canEdit,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'necessary field';
                                  } else if (value == "male" ||
                                      value == "female") {
                                    return null;
                                  }
                                  return "male or female";
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              width: queryData.size.width / 2 - 30,
                              child: CustomTextField(
                                controller: ageController,
                                hintText: "age",
                                readOnly: !canEdit,
                                keyType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          controller: wardController,
                          hintText: "ward",
                          readOnly: !canEdit,
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Flexible(
                              child: CustomTextField(
                                controller: roomNumController,
                                hintText: "roomNum",
                                readOnly: !canEdit,
                              ),
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              width: queryData.size.width / 2 - 30,
                              child: CustomTextField(
                                controller: bedNumController,
                                hintText: "bedNum",
                                readOnly: !canEdit,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 100),
                  if (isPortrait == false) ...[SizedBox(height: 40)],
                  if (canEdit == true) ...[
                    CustomTextButton(
                        onTap: () async {
                          log("cliked update");
                          if (_formKey.currentState!.validate()) {
                            PatientUser service = PatientUser();
                            PatientUser val = PatientUser(
                              name: nameController.text,
                              gender: genderController.text.trim(),
                              age: int.parse(ageController.text.trim()),
                              ward: wardController.text.trim(),
                              roomNum: roomNumController.text.trim(),
                              bedNum: bedNumController.text.trim(),
                            );
                            showSnackBar(context, "Patient Updated");
                            await service.updatePatient(val);
                          }
                        },
                        fullWidth: true,
                        children: SvgPicture.asset(kCheckUp),
                        label: "Update Details")
                  ] else ...[
                    CustomTextButton(
                        onTap: () {
                          AuthService service =
                              AuthService(FirebaseAuth.instance);
                          service.signOut(context);
                          Navigator.pushNamedAndRemoveUntil(context, "/landing",
                              (Route<dynamic> route) => false);
                        },
                        fullWidth: true,
                        children: SvgPicture.asset(kLogout),
                        label: "logout")
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
