import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/CustomTextButton.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Doctor/components/addPatient.dart';
import 'package:patient_app/screens/Doctor/components/assignedPatients.dart';

class DocPatient extends StatefulWidget {
  const DocPatient({Key? key}) : super(key: key);

  @override
  State<DocPatient> createState() => _DocPatientState();
}

class _DocPatientState extends State<DocPatient> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Your Patients",
                          style: TextStyle(
                              fontSize: 28, fontWeight: kh3FontWeight)),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                    height: MediaQuery.of(context).size.height / 1.75,
                    child: AssignedPatients()),
                CustomTextButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddPatient()),
                      );
                    },
                    fullWidth: true,
                    label: "Add Patient",
                    children: SvgPicture.asset(kAdd))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
