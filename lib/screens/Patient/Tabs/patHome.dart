import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_app/components/BookTap.dart';
import 'package:patient_app/components/Greetings.dart';
import 'package:patient_app/components/InfoCard.dart';
import 'package:patient_app/constants.dart';
import 'package:patient_app/screens/Patient/patLogin.dart';
import 'package:patient_app/services/AuthService.dart';
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

            return user == null
                ? const PatLogin()
                : SafeArea(
                    child: Scaffold(
                      body: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
                          child: Column(
                            children: [
                              const Greetings(
                                greet: "Good morning",
                                personName: "Ms Leny",
                              ),
                              const SizedBox(height: 30),
                              const InfoCard(
                                posType: "Doctor incharge",
                                name: "Dr. Park",
                                nextVisit: "Next visit at 4pm",
                                svgPath: kDocCircle,
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
                                  color: kSosColor,
                                  borderRadius:
                                      BorderRadius.circular(kBorderRadius),
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
                                  borderRadius:
                                      BorderRadius.circular(kBorderRadius),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 25.5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset(kClockLogo),
                                        const SizedBox(width: 14.12),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                          fontWeight:
                                                              kh4FontWeight),
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
