import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomTextButton.dart';
import 'package:patient_app/components/CustomTextField.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/services/AuthService.dart';
import 'package:patient_app/services/doctorUser.dart';
import 'package:patient_app/utils/showSnackBar.dart';

class DocProfile extends StatelessWidget {
  const DocProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DoctorUser service = DoctorUser();
    late final Future<Object>? future = service.getDoctor();
    return SafeArea(
      child: FutureBuilder<Object>(
          future: future,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return DocChildWrapper(
                name: snapshot.data["name"],
                gender: snapshot.data["gender"],
                age: snapshot.data["age"],
                qualification: snapshot.data["qualification"],
                department: snapshot.data["department"],
              );
            } else
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
          }),
    );
  }
}

class DocChildWrapper extends StatefulWidget {
  final String name;
  final int age;
  final String gender;
  final String qualification;
  final String department;
  const DocChildWrapper({
    Key? key,
    required this.name,
    required this.gender,
    required this.age,
    required this.qualification,
    required this.department,
  }) : super(key: key);

  @override
  State<DocChildWrapper> createState() =>
      _DocChildWrapperState(name, age, gender, qualification, department);
}

class _DocChildWrapperState extends State<DocChildWrapper> {
  final String name;
  final int age;
  final String gender;
  final String qualification;
  final String department;
  _DocChildWrapperState(
      this.name, this.age, this.gender, this.qualification, this.department);
  bool canEdit = false;
  DoctorUser service = DoctorUser();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController departmentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = name;
    genderController.text = gender;
    ageController.text = age.toString();
    qualificationController.text = qualification;
    departmentController.text = department;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    @override
    void dispose() {
      nameController.dispose();
      genderController.dispose();
      ageController.dispose();
      qualificationController.dispose();
      departmentController.dispose();
      super.dispose();
    }

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: isPortrait == true
                ? MediaQuery.of(context).size.height - 40
                : 0,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                      Column(
                        children: [
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
                            controller: qualificationController,
                            hintText: "Qualification details",
                            readOnly: !canEdit,
                          ),
                          SizedBox(height: 20),
                          CustomTextField(
                            controller: departmentController,
                            hintText: "Department",
                            readOnly: !canEdit,
                          ),
                        ],
                      ),
                    ],
                  ),
                  // SizedBox(height: 100),
                  if (isPortrait == false) ...[SizedBox(height: 40)],
                  if (canEdit == true) ...[
                    CustomTextButton(
                        color: k3Color,
                        onTap: () async {
                          log("cliked update");
                          if (_formKey.currentState!.validate()) {
                            DoctorUser service = DoctorUser();
                            DoctorUser val = DoctorUser(
                              name: nameController.text,
                              gender: genderController.text.trim(),
                              age: int.parse(ageController.text.trim()),
                              qualification: qualificationController.text,
                              department: departmentController.text,
                            );
                            showSnackBar(context, "Doctor Updated");
                            await service.updateDoctor(val);
                          }
                        },
                        fullWidth: true,
                        children: SvgPicture.asset(kCheckUp),
                        label: "Update Details")
                  ] else ...[
                    CustomTextButton(
                        color: k3Color,
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
