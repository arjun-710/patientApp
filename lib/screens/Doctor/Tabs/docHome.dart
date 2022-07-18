import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/BookTap.dart';
import 'package:patient_app/components/CustomText.dart';
import 'package:patient_app/components/Greetings.dart';
import 'package:patient_app/components/InfoCard.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Doctor/components/PatList.dart';
import 'package:patient_app/screens/Doctor/components/docProfile.dart';
import 'package:patient_app/screens/Doctor/docLogin.dart';
import 'package:patient_app/services/AuthService.dart';
import 'package:provider/provider.dart';

class PatDetails extends StatelessWidget {
  const PatDetails({Key? key}) : super(key: key);

  Text CustomText(data) {
    return Text(data,
        style: const TextStyle(fontSize: kh4size, color: kStrokeColor));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(kBed),
        SizedBox(width: 10),
        CustomText("general"),
        CustomText(" | "),
        CustomText("R-32"),
        CustomText(" | "),
        CustomText("B-16")
      ],
    );
  }
}

class DocHome extends StatelessWidget {
  const DocHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<User?>(
        stream: authService.authState,
        builder: (_, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            return user == null
                ? const DocLogin()
                : SafeArea(
                    child: Scaffold(
                      body: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
                          child: Column(
                            children: [
                              Greetings(
                                greet: "Good morning,",
                                personName: "Dr. Park",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DocProfile()),
                                  );
                                },
                              ),
                              const SizedBox(height: 30),
                              const InfoCard(
                                posType: "Emergency patient",
                                name: "Ms. Leny",
                                nextVisit: "Next visit at 4pm",
                                svgPath: kEmergencyWard,
                                child: PatDetails(),
                              ),
                              const SizedBox(height: 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  H3Text(
                                    text: "Patients to check today",
                                    weight: kh3FontWeight,
                                  ),
                                  SizedBox(height: 20),
                                  SingleChildScrollView(
                                    child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2.75,
                                        child: PatList()),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
