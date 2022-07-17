import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomTextButton.dart';
import 'package:patient_app/components/CustomTextField.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/services/AuthService.dart';
import 'package:patient_app/services/patientUser.dart';

class PatProfile extends StatefulWidget {
  const PatProfile({Key? key}) : super(key: key);

  @override
  State<PatProfile> createState() => _PatProfileState();
}

class _PatProfileState extends State<PatProfile> {
  bool canEdit = false;
  PatientUser service = PatientUser();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController genderController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController wardController = TextEditingController();
    TextEditingController roomNumController = TextEditingController();
    TextEditingController bedNumController = TextEditingController();
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    @override
    void dispose() {
      nameController.dispose();
      genderController.dispose();
      ageController.dispose();
      wardController.dispose();
      roomNumController.dispose();
      bedNumController.dispose();
      super.dispose();
    }

    return SafeArea(
      child: FutureBuilder<Object>(
          future: service.getPatient(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              nameController.value =
                  nameController.value.copyWith(text: snapshot.data!["name"]);
              genderController.value = genderController.value
                  .copyWith(text: snapshot.data!["gender"]);
              ageController.value = ageController.value
                  .copyWith(text: snapshot.data!["age"].toString());
              wardController.value =
                  wardController.value.copyWith(text: snapshot.data!["ward"]);
              roomNumController.value = roomNumController.value
                  .copyWith(text: snapshot.data!["roomNum"]);
              bedNumController.value = bedNumController.value
                  .copyWith(text: snapshot.data!["bedNum"]);

              var isPortrait =
                  MediaQuery.of(context).orientation == Orientation.portrait;

              return Scaffold(
                body: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: isPortrait == true
                          ? MediaQuery.of(context).size.height - 40
                          : 0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                children: [
                                  Flexible(
                                    child: CustomTextField(
                                      controller: genderController,
                                      hintText: "gender",
                                      readOnly: !canEdit,
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
                                      hintText: "Ward",
                                      readOnly: !canEdit,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    width: queryData.size.width / 2 - 30,
                                    child: CustomTextField(
                                      controller: bedNumController,
                                      hintText: "bed no.",
                                      readOnly: !canEdit,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // SizedBox(height: 100),
                          if (isPortrait == false) ...[SizedBox(height: 40)],
                          if (canEdit == true) ...[
                            CustomTextButton(
                                onTap: () {},
                                fullWidth: true,
                                children: SvgPicture.asset(kCheckUp),
                                label: "Update Details")
                          ] else ...[
                            CustomTextButton(
                                onTap: () {
                                  AuthService service =
                                      AuthService(FirebaseAuth.instance);
                                  service.signOut(context);
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
              );
            } else
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
          }),
    );
  }
}
