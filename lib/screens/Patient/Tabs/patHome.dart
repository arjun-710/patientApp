import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/BookTap.dart';
import 'package:patient_app/components/Greetings.dart';
import 'package:patient_app/components/InfoCard.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Patient/components/patProfile.dart';
import 'package:patient_app/screens/Patient/patLogin.dart';
import 'package:patient_app/services/AuthService.dart';
import 'package:patient_app/services/patientUser.dart';
import 'package:provider/provider.dart';

class PatHome extends StatelessWidget {
  const PatHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<User?>(
        stream: authService.authState,
        builder: (_, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            PatientUser service = PatientUser();
            late final Future<Object>? future = service.getPatient();
            return user == null
                ? const PatLogin()
                : SafeArea(
                    child: FutureBuilder<Object>(
                        future: future,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return homeWidget(
                              name: snapshot.data["name"],
                              gender: snapshot.data["gender"],
                              age: snapshot.data["age"],
                              ward: snapshot.data["ward"],
                              roomNum: snapshot.data["roomNum"],
                              bedNum: snapshot.data["bedNum"],
                            );
                          } else
                            return Scaffold(
                              body: Center(child: CircularProgressIndicator()),
                            );
                        }),
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

class homeWidget extends StatelessWidget {
  final String name;
  final int age;
  final String bedNum;
  final String gender;
  final String ward;
  final String roomNum;
  const homeWidget({
    Key? key,
    required this.name,
    required this.age,
    required this.bedNum,
    required this.gender,
    required this.ward,
    required this.roomNum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
          child: Column(
            children: [
              Greetings(
                greet: "Good morning",
                personName: name,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PatProfile(
                                age: age,
                                bedNum: bedNum,
                                gender: gender,
                                name: name,
                                roomNum: roomNum,
                                ward: ward,
                              )));
                },
              ),
              const SizedBox(height: 30),
              const InfoCard(
                posType: "Doctor incharge",
                name: "Dr. Park",
                age: "21",
                gender: "male",
                svgPath: kDocCircle,
                child: SizedBox.shrink(),
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Continue Reading",
                    style: TextStyle(fontSize: kh2size),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    height: 140,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        BookTap(
                          assetPath: kBook1,
                          onTap: () {},
                        ),
                        BookTap(
                          assetPath: kBook2,
                          onTap: () {},
                        ),
                        BookTap(
                          assetPath: kBook3,
                          onTap: () {},
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                padding: EdgeInsets.symmetric(vertical: 22.5),
                decoration: BoxDecoration(
                  color: k3Color,
                  borderRadius: BorderRadius.circular(kBorderRadius),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(kEmergency),
                    SizedBox(width: 15),
                    Text(
                      "SOS",
                      style: TextStyle(fontSize: kh2size),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: kMedCardColor,
                  borderRadius: BorderRadius.circular(kBorderRadius),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 25.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(kClockLogo),
                        const SizedBox(width: 14.12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'Medicine Time in',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: kh6FontWeight,
                                      fontSize: kh3size),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' 50min.',
                                      style: TextStyle(
                                          fontSize: kh2size,
                                          fontWeight: kh4FontWeight),
                                    )
                                  ]),
                            ),
                            // Text("Medicine time in 50min.",
                            //     style: TextStyle(
                            //         fontSize: kh4size)),
                          ],
                        ),
                      ],
                    ),
                    SvgPicture.asset(kRight)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
